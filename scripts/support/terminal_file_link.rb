#!/usr/bin/env ruby
# frozen_string_literal: true

require "cgi"
require "shellwords"
require "yaml"

module TerminalFileLink
  module_function

  IMAGE_EXTENSIONS = %w[.png .jpg .jpeg .webp .gif].freeze
  TERMINAL_PREFERENCES_PATH = File.expand_path("../../state/terminal.yaml", __dir__)
  TERMINAL_PREFERENCES_TEMPLATE_PATH = File.expand_path("../../state/terminal.template.yaml", __dir__)

  def file_link_lines(path:, kind: "auto", fallback_label: nil)
    absolute_path = File.expand_path(path)
    raise ArgumentError, "File not found: #{absolute_path}" unless File.exist?(absolute_path)

    resolved_kind = resolve_kind(absolute_path, kind)
    label = fallback_label || default_label_for(resolved_kind)
    preferences = terminal_preferences

    lines = [osc8_link(file_uri(absolute_path), label)]
    lines << "open #{Shellwords.escape(absolute_path)}" if macos? && include_open_fallback?(preferences)
    lines
  end

  def resolve_kind(path, kind)
    return kind unless kind == "auto"

    IMAGE_EXTENSIONS.include?(File.extname(path).downcase) ? "image" : "file"
  end

  def default_label_for(kind)
    kind == "image" ? "[Открыть изображение]" : "[Открыть файл]"
  end

  def terminal_preferences
    preferences_path = if File.exist?(TERMINAL_PREFERENCES_PATH)
      TERMINAL_PREFERENCES_PATH
    elsif File.exist?(TERMINAL_PREFERENCES_TEMPLATE_PATH)
      TERMINAL_PREFERENCES_TEMPLATE_PATH
    end

    return {} unless preferences_path

    YAML.load_file(preferences_path) || {}
  rescue Psych::SyntaxError
    {}
  end

  def include_open_fallback?(preferences)
    link_preferences = preferences.fetch("link", {})
    link_preferences.fetch("include_open_fallback", true)
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
