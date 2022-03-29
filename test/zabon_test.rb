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

  def test_newline
    assert_equal ["\n"], Zabon.split("\n")
  end

  def test_spaces
    assert_equal [" "], Zabon.split(" ")
  end

  # Meistertask translations

  def test_meistertask1
    # Task management is the link between planning to do something and getting it done. Your task management software should provide an overview of work in progress that enables tracking from conception to completion. Enter MeisterTask: join teams everywhere who use our Kanban-style project boards to digitalize workflows and gain a clear overview of task progress. Let's get organized together!
    source = "タスク管理は、何かをしようと計画することと、それを実行することを結びつけるものです。タスク管理ソフトウェアは、構想から完成までを追跡できるように、進行中の作業の概要を提供しなければなりません。MeisterTaskを利用すれば、タスクの進捗状況を明確に把握するために、ワークフローをデジタル化し、カンバン方式のプロジェクトボードを使用しているチームに参加することができます。一緒に準備して整理しましょう！"
    expected = ["タスク", "管理は、", "何かをしようと", "計画することと、", "それを", "実行することを", "結びつけるものです。", "タスク", "管理", "ソフトウェアは、", "構想から", "完成までを", "追跡できるように、", "進行中の", "作業の", "概要を", "提供しなければなりません。",
                "MeisterTaskを", "利用すれば、", "タスクの", "進捗状況を", "明確に", "把握するために、", "ワークフローを", "デジタル", "化し、", "カンバン", "方式の", "プロジェクトボードを", "使用している", "チームに", "参加することができます。", "一緒に", "準備して", "整理しましょう！"]

    assert_equal expected, Zabon.split(source)
    assert_equal source, expected.join
  end

  def test_meistertask2
    # Task management is the structured, digitalized processing of tasks using a dedicated software. MeisterTask is an excellent example, but many others do exist.
    source = "タスク管理とは、専用のソフトウェアを使ってタスクを構造的にデジタル処理することです。MeisterTaskが代表的な例ですが、他にも様々なソフトがあります。"
    expected = ["タスク", "管理とは、", "専用の", "ソフトウェアを", "使って", "タスクを", "構造的に", "デジタル", "処理することです。", "MeisterTaskが", "代表的な", "例ですが、", "他にも", "様々な", "ソフトがあります。"]

    assert_equal expected, Zabon.split(source)
    assert_equal source, expected.join
  end

  def test_meistertask3
    # MeisterTask's Gantt-style Timeline feature helps project managers drive efficiency and keep their teams aligned. Assign and schedule tasks in calendar view to locate bottlenecks easily and ensure deadlines are kept.
    source = "MeisterTaskのガントスタイルのタイムライン機能は、プロジェクトマネージャーが効率を高め、チームの連携を維持するのに役立ちます。カレンダービューでタスクを割り当ててスケジュールし、ボトルネックを簡単に見つけて期限を守るようにします。"
    expected = ["MeisterTaskの", "ガントスタイルの", "タイムライン", "機能は、", "プロジェクトマネージャーが", "効率を", "高め、", "チームの", "連携を", "維持するのに", "役立ちます。", "カレンダービューで", "タスクを", "割り", "当てて", "スケジュールし、",
                "ボトルネックを", "簡単に", "見つけて", "期限を", "守るようにします。"]

    assert_equal expected, Zabon.split(source)
    assert_equal source, expected.join
  end

  def test_meistertask4
    # MeisterTask's Gantt-style Timeline feature helps project managers drive efficiency and keep their teams aligned. Assign and schedule tasks in calendar view to locate bottlenecks easily and ensure deadlines are kept.
    source = "MeisterTaskのガントスタイルのタイムライン機能は、プロジェクトマネージャーが効率を高め、チームの連携を維持するのに役立ちます。カレンダービューでタスクを割り当ててスケジュールし、ボトルネックを簡単に見つけて期限を守るようにします。"
    expected = ["MeisterTaskの", "ガントスタイルの", "タイムライン", "機能は、", "プロジェクトマネージャーが", "効率を", "高め、", "チームの", "連携を", "維持するのに", "役立ちます。", "カレンダービューで", "タスクを", "割り", "当てて", "スケジュールし、",
                "ボトルネックを", "簡単に", "見つけて", "期限を", "守るようにします。"]

    assert_equal expected, Zabon.split(source)
    assert_equal source, expected.join
  end
end
