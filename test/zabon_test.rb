# frozen_string_literal: true

require "test_helper"

class ZabonTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Zabon::VERSION
  end

  def test_sentence1
    # Always the latest and best mobile. From the same team that developed Android.
    source = "常に最新、最高のモバイル。Androidを開発した同じチームから。"
    expected = ["常に", "最新、", "最高の", "モバイル。", "Androidを", "開発した", "同じ", "チームから。"]

    assert_equal expected, Zabon.split(source)
    assert_equal source, expected.join
  end

  def test_sentence2
    # Please prepare the manuscript and disaster prevention clothes.
    source = "原稿と防災服を用意してくれ"
    expected = %w[原稿と 防災服を 用意してくれ]

    assert_equal expected, Zabon.split(source)
    assert_equal source, expected.join
  end

  def test_sentence3
    # Besides, what you want to do
    source = "やりたいことのそばにいる"
    expected = %w[やりたいことの そばに いる]

    assert_equal expected, Zabon.split(source)
    assert_equal source, expected.join
  end

  def test_sentence4
    # This library called zabon.ruby enables smart character delimiters.
    source = "このzabon.rubyというライブラリは、スマートな文字区切りを可能にします。"
    expected = ["この", "zabon.rubyと", "いう", "ライブラリは、", "スマートな", "文字区切りを", "可能にします。"]

    assert_equal expected, Zabon.split(source)
    assert_equal source, expected.join
  end

  def test_sentence5
    # Do you want to use a template or start with a blank survey?
    source = "テンプレートを使用しますか、それとも空白の調査から始めますか？"
    expected = ["テンプレートを", "使用しますか、", "それとも", "空白の", "調査から", "始めますか？"]

    assert_equal expected, Zabon.split(source)
    assert_equal source, expected.join
  end

  def test_sentence6
    # Neither "that" nor "this".
    source = "「あれ」でもない、「これ」でもない。"
    expected = ["「あれ」", "でもない、", "「これ」", "でもない。"]

    assert_equal expected, Zabon.split(source)
    assert_equal source, expected.join
  end

  def test_sentence7
    # Supports half-width spaces
    source = "半角スペース 対応"
    expected = ["半角", "スペース", " ", "対応"]

    assert_equal expected, Zabon.split(source)
    assert_equal source, expected.join
  end

  def test_sentence8
    # You should go by taxi, otherwise you may not be in time.
    source = "タクシーで行くべきでしょ、でないと間に合わないかもしれないよ。"
    expected = ["タクシーで", "行くべきでしょ、", "でないと", "間に", "合わないかもしれないよ。"]

    assert_equal expected, Zabon.split(source)
    assert_equal source, expected.join
  end

  def test_particle_node
    # Since the weather is nice, let's go outside.
    source = "天気がいいので外に出かけましょう。"
    expected = %w[天気がいいので 外に 出かけましょう。]

    assert_equal expected, Zabon.split(source)
    assert_equal source, expected.join
  end

  def test_newline
    assert_equal ["\n"], Zabon.split("\n")
  end

  def test_spaces
    assert_equal [" "], Zabon.split(" ")
  end

  def test_wrestling_long_sentence
    # A wrestler's journey — long mixed-script sentence with Katakana loanwords and Kanji.
    source = "プロレスラーはリングに上がる前に、長い年月のトレーニングと厳しい練習を積んでいます。ファンの声援がエネルギーとなり、試合で最高のパフォーマンスを発揮します。"
    expected = ["プロレスラーは", "リングに", "上がる", "前に、", "長い", "年月の", "トレーニングと", "厳しい", "練習を", "積んでいます。", "ファンの", "声援が", "エネルギーとなり、", "試合で", "最高の", "パフォーマンスを", "発揮します。"]

    assert_equal expected, Zabon.split(source)
    assert_equal source, expected.join
  end

  def test_wrestling_katakana_moves
    # Move names as Katakana loanwords followed by Japanese particles.
    source = "プロレスの技には、ジャーマンスープレックスやタイガースープレックスなど、様々な投げ技があります。美しいフォームと力強さが観客を魅了します。"
    expected = ["プロレスの", "技には、", "ジャーマンスープレックスや", "タイガースープレックスなど、", "様々な", "投げ", "技があります。", "美しい", "フォームと", "力強さが", "観客を", "魅了します。"]

    assert_equal expected, Zabon.split(source)
    assert_equal source, expected.join
  end
end
