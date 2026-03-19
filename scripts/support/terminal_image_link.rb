#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require_relative "terminal_file_link"

module TerminalImageLink
  module_function

  KITTY_BLOCK_START = "# >>> product-engine image open_actions >>>"
  KITTY_BLOCK_END = "# <<< product-engine image open_actions <<<"

  def preview_lines(path:, kitty_label: "[Показать изображение]", fallback_label: "[Открыть изображение]")
    file_link_lines(path: path, kind: "image", kitty_label: kitty_label, fallback_label: fallback_label)
  end

  def file_link_lines(path:, kind: "auto", kitty_label: "[Показать изображение]", fallback_label: "[Открыть файл]")
    absolute_path = File.expand_path(path)
    raise ArgumentError, "File not found: #{absolute_path}" unless File.exist?(absolute_path)

    resolved_kind = TerminalFileLink.resolve_kind(absolute_path, kind)

    if resolved_kind == "image" && kitty_terminal?
      ensure_kitty_open_actions!
      [
        TerminalFileLink.osc8_link(TerminalFileLink.file_uri(absolute_path), kitty_label)
      ]
    else
      TerminalFileLink.file_link_lines(
        path: absolute_path,
        kind: resolved_kind,
        fallback_label: fallback_label
      )
    end
  end

  def kitty_terminal?
    ENV["TERM"] == "xterm-kitty" || !ENV["KITTY_WINDOW_ID"].to_s.empty?
  end

  def kitty_config_path
    File.expand_path("~/.config/kitty/kitty.conf")
  end

  def ensure_kitty_open_actions!
    path = kitty_config_path
    directory = File.dirname(path)
    FileUtils.mkdir_p(directory) unless Dir.exist?(directory)

    content = File.exist?(path) ? File.read(path) : ""
    updated = upsert_kitty_block(content)
    return if updated == content

    File.write(path, updated)
  end

  def upsert_kitty_block(content)
    managed_block = managed_kitty_block

    if content.include?(KITTY_BLOCK_START) && content.include?(KITTY_BLOCK_END)
      return content.sub(
        /#{Regexp.escape(KITTY_BLOCK_START)}.*?#{Regexp.escape(KITTY_BLOCK_END)}/m,
        managed_block
      )
    end

    paragraphs = content.split(/\n{2,}/, -1)
    image_block_index = paragraphs.index { |paragraph| paragraph.match?(/\bmime\s+image\/\*/) }

    if image_block_index
      return content if compatible_kitty_image_block?(paragraphs[image_block_index])

      paragraphs[image_block_index] = managed_block
      return paragraphs.join("\n\n").sub(/\A\n+/, "").concat("\n")
    end

    base = content.rstrip
    return "#{managed_block}\n" if base.empty?

    "#{base}\n\n#{managed_block}\n"
  end

  def compatible_kitty_image_block?(block)
    block.match?(/\bmime\s+image\/\*/) && block.match?(/(?:^|\s)(?:kitten|kitty\s+\+kitten)\s+icat\b/)
  end

  def managed_kitty_block
    [
      KITTY_BLOCK_START,
      "protocol file",
      "mime image/*",
      "action launch --type=overlay kitten icat --hold -- %1",
      KITTY_BLOCK_END
    ].join("\n")
  end
end
