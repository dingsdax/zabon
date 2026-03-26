# frozen_string_literal: true

require "test_helper"

class ZabonTest < Minitest::Test
  include Zabon::Helper
  include ActionView::Helpers

  def setup
    I18n.available_locales = %i[en ja]
    I18n.default_locale = :en
    I18n.backend = I18n::Backend::Simple.new
    I18n.load_path = [File.join(locales_dir, "/en.yml"), File.join(locales_dir, "/ja.yml")]

    Zabon.configure do |config|
      config.tag_options = {}
      config.strip_tags = true
    end
  end

  def test_translate_from_rails_unless_locale_is_ja
    assert_equal translate(:main_title), zabon_translate(:main_title)
  end

  def test_missing_translation_en
    expected = %(<span class="translation_missing" title="translation missing: en.not_found">Not Found</span>)

    assert_equal expected, zabon_translate(:not_found)
  end

  def test_missing_translation_ja
    expected = %(<span class="translation_missing" title="translation missing: ja.not_found, locale: ja">Not Found</span>)

    assert_equal expected, zabon_translate(:not_found, locale: :ja)
  end

  def test_strip_tags
    expected = "<span>あなたの</span><span>チームが</span><span>認識を</span><span>共有</span>"

    assert_equal expected, zabon_translate(:main_title, locale: :ja)
  end

  def test_configuration
    Zabon.configure do |config|
      config.tag = :div # default: :span
      config.tag_options = { class: "zabon_trara", style: "font_size: 5em" } # default:  { class: 'zabon', style: 'display: inline-block' }
      config.strip_tags = false # default true
    end

    expected = %(<div class="zabon_trara" style="font_size: 5em">構成</div>)

    assert_equal expected, zabon_translate(:configuration, locale: :ja)

    Zabon.reset_config!
  end

  def test_long_text
    expected = <<~RESULT.gsub(/[\n\s]+/, "")
      <span>プロレスは</span>
      <span>、</span>
      <span>日本の</span>
      <span>スポーツ</span>
      <span>文化に</span>
      <span>おいて</span>
      <span>重要な</span>
      <span>役割を</span>
      <span>果たしてきました。</span>
      <span>試合では、</span>
      <span>技の</span>
      <span>美しさと</span>
      <span>力強さが</span>
      <span>求められます。</span>
      <span>レスラーたちは</span>
      <span>長年の</span>
      <span>厳しい</span>
      <span>トレーニングを</span>
      <span>積み、</span>
      <span>観客を</span>
      <span>魅了する</span>
      <span>演技を</span>
      <span>披露します。</span>
      <span>リングの</span>
      <span>上での</span>
      <span>戦いは、</span>
      <span>単なる</span>
      <span>勝敗を</span>
      <span>超えた</span>
      <span>芸術的な</span>
      <span>表現です。</span>
      <span>勝利を</span>
      <span>目指して</span>
      <span>力の</span>
      <span>限り</span>
      <span>戦う</span>
      <span>レスラーの</span>
      <span>姿に、</span>
      <span>ファンは</span>
      <span>熱い</span>
      <span>声援を</span>
      <span>送ります。</span>
    RESULT

    assert_equal expected, zabon_translate(:sample_text, locale: :ja)
  end

  def text_default_configuration; end

  private

  def locales_dir
    "#{File.dirname(__FILE__)}/test_data/locales"
  end
end
