# frozen_string_literal: true

require "test_helper"

class ZabonTest < Minitest::Test
  include Zabon::Helper
  include ActionView::Helpers

  def setup
    I18n.available_locales = [:en, :ja]
    I18n.default_locale = :en
    I18n.backend = I18n::Backend::Simple.new
    I18n.load_path = [File.join(locales_dir, '/en.yml'), File.join(locales_dir,  '/ja.yml')]

    Zabon.configure do |config|
      config.tag_options = {}
      config.strip_tags = true
    end
  end

  def test_translate_from_rails_unless_locale_is_ja
    assert_equal translate(:main_title), zabon_translate(:main_title)
  end

  def test_missing_translation_en
    expected = %Q|<span class="translation_missing" title="translation missing: en.not_found">Not Found</span>|

    assert_equal expected, zabon_translate(:not_found)
  end

  def test_missing_translation_ja
    expected = %Q|<span class="translation_missing" title="translation missing: ja.not_found, locale: ja">Not Found</span>|

    assert_equal expected, zabon_translate(:not_found, locale: :ja)
  end

  def test_strip_tags
    expected = "<span>あなたの</span><span>チームが</span><span>認識を</span><span>共有</span>"

    assert_equal expected, zabon_translate(:main_title, locale: :ja)
  end

  def test_configuration
    Zabon.configure do |config|
      config.tag = :div # default: :span
      config.tag_options = { class: 'zabon_trara', style: 'font_size: 5em' } # default:  { class: 'zabon', style: 'display: inline-block' }
      config.strip_tags = false # default true
    end

    expected = %Q|<div class="zabon_trara" style="font_size: 5em">構成</div>|

    assert_equal expected, zabon_translate(:configuration, locale: :ja)

    Zabon.reset_config!
  end

  def test_long_text
    expected = <<~RESULT.gsub(/[\n\s]+/, '');
      <span>タスク</span>
      <span>管理は、</span>
      <span>何かをしようと</span>
      <span>計画することと、</span>
      <span>それを</span>
      <span>実行することを</span>
      <span>結びつけるものです。</span>
      <span>タスク</span>
      <span>管理</span>
      <span>ソフトウェアは、</span>
      <span>構想から</span>
      <span>完成までを</span>
      <span>追跡できるように、</span>
      <span>進行中の</span>
      <span>作業の</span>
      <span>概要を</span>
      <span>提供しなければなりません。</span>
      <span>MeisterTaskを</span>
      <span>利用すれば、</span>
      <span>タスクの</span>
      <span>進捗状況を</span>
      <span>明確に</span>
      <span>把握するために、</span>
      <span>ワークフローを</span>
      <span>デジタル</span>
      <span>化し、</span>
      <span>カンバン</span>
      <span>方式の</span>
      <span>プロジェクトボードを</span>
      <span>使用している</span>
      <span>チームに</span>
      <span>参加することができます。</span>
      <span>一緒に</span>
      <span>準備して</span>
      <span>整理しましょう！</span>
    RESULT

    assert_equal expected, zabon_translate(:mt_intro_text, locale: :ja)
  end

  def text_default_configuration

  end

  private

  def locales_dir
    File.dirname(__FILE__) + '/test_data/locales'
  end
end
