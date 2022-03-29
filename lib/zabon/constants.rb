# frozen_string_literal: true

module Zabon
  # Joshi (助詞), Japanese particles written in Hiragana, are suffixes or short words that follow a modified noun, verb, adjective, or sentence.
  # Some particals can appear in two types. They give pretty reliable cues depending on the following character, whether a line break is allowed or not.
  JOSHI = /
    (でなければ|について|かしら|くらい|けれど|なのか|ばかり|ながら|ことよ|こそ|こと|さえ|しか|した|たり|だけ|だに|だの|つつ|ても|てよ|でも|
    とも|から|など|なりので|のに|ほど|まで|もの|やら|より|って|で|と|な|に|ね|の|も|は|ば|へ|や|わ|を|か|が|さ|し|ぞ|て)
  /x.freeze

  # A simple way to find word segementations in Japanese is
  # to tokenise by grouping characters continuously by script (Hiragana, Katakana, Kanji, Romaji)
  #
  # The following regular expression matches in this order:
  # * non breaking space
  # * domains
  # * any Japanese Kanji or Chinese character
  # * Hirgana (+ chisai kana)
  # * Katakana (+ chisai kana)
  # * Latin
  # * Latin (double width)
  KEYWORDS = /
    (\&nbsp;|
    [a-zA-Z0-9]+\.[a-z]{2,}|
    [一-龠々〆ヵヶゝ]+|
    [ぁ-んゝ]+|
    [ァ-ヴー]+|
    [a-zA-Z0-9]+|
    [ａ-ｚＡ-Ｚ０-９]+)
  /x.freeze

  # Brackets & Quotations
  BRACKETS_BEGIN = /([〈《「『｢（(\[【〔〚〖〘❮❬❪❨(<{❲❰｛❴])/.freeze
  BRACKETS_END   = /([〉》」』｣)）\]】〕〗〙〛}>\)❩❫❭❯❱❳❵｝])/.freeze

  PERIODS = /([\.\,。、！\!？\?]+)$/.freeze

  HIRAGANA = /[ぁ-んゝ]+/.freeze
end
