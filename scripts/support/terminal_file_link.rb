#!/usr/bin/env ruby
# frozen_string_literal: true

require "cgi"
require "shellwords"

module TerminalFileLink
  module_function

  IMAGE_EXTENSIONS = %w[.png .jpg .jpeg .webp .gif].freeze

  def file_link_lines(path:, kind: "auto", fallback_label: nil)
    absolute_path = File.expand_path(path)
    raise ArgumentError, "File not found: #{absolute_path}" unless File.exist?(absolute_path)

    resolved_kind = resolve_kind(absolute_path, kind)
    label = fallback_label || default_label_for(resolved_kind)

    lines = [osc8_link(file_uri(absolute_path), label)]
    lines << "open #{Shellwords.escape(absolute_path)}" if macos?
    lines
  end

  def resolve_kind(path, kind)
    return kind unless kind == "auto"

    IMAGE_EXTENSIONS.include?(File.extname(path).downcase) ? "image" : "file"
  end

  def default_label_for(kind)
    kind == "image" ? "[Открыть изображение]" : "[Открыть файл]"
  end

  def macos?
    /darwin/i.match?(RUBY_PLATFORM)
  end

  def file_uri(path)
    "file://" + path.split("/").map { |segment| CGI.escape(segment).gsub("+", "%20") }.join("/")
  end

  def osc8_link(uri, label)
    "\e]8;;#{uri}\a#{label}\e]8;;\a"
  end
end
