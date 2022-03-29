# zabon.ruby 🍊

A Ruby gem / Rails helper for dealing with Japanese line-breaking logic. It is basically a port of [mikan.js](https://github.com/trkbt10/mikan.js), which implements a regular expression based algorithm to segment text into semantic chunks. No machine learning needed 🤖☺️. In addition the resulting text segments can be wrapped in a configurable HTML tag. All praise 👏👏👏 for the algorithm goes to [trkbt10](https://github.com/trkbt10).

## Usage
``` ruby
# split this sentence
Zabon.split('この文を分割する')
 => ["この", "文を", "分割する"]

```

## Configuration

Configuration is used for tag that the results can be wrapped in. It's making heavy use of Rails tag helpers.
E.g. put this in an initializer in your Rails app.

``` ruby
Zabon.configure do |config|
  config.tag = :div # default: :span
  config.tag_options = { class: 'zabon_trara', style: 'font_size: 5em' } # default:  { class: 'zabon', style: 'display: inline-block' }
  config.strip_tags = false # default true
end
```

### Rails

```
TODO:
```

## Japanese grammar 🇯🇵

Just enough Japanese to understand the algorithm :)

### Writing system ✍️

The Japanese writing system uses for different components:

* [Hiragana (ひらがな)](https://en.wikipedia.org/wiki/Hiragana), a syllabary alphabet used for Japanese words not covered by kanji and moestly for grammatical inflections
* [Katakana (カタカナ)](https://en.wikipedia.org/wiki/Katakana), a syllabary alphabet used for transcription of foreign-language words into Japanese; for emphasis; [onomatopoeia](https://en.wikipedia.org/wiki/Onomatopoeia); for scientific terms and often Japanese companies.
* [Kanji (漢字)](https://en.wikipedia.org/wiki/Kanji), a set of Chinese characters directly incorporated into the written Japanese language with often Japanese pronunciation, which can be
* Romanji

### Particles

[Joshi (助詞)](https://en.wikipedia.org/wiki/Japanese_particles), Japanese particles written in Hiragana, are suffixes or short words that follow a modified noun, verb, adjective, or sentence. Their grammatical range can indicate various meanings and functions:

* case markers
* parallel markers
* sentence ending particles
* interjectory particles
* adverbial particles
* binding particles
* conjunctive particles
* phrasal particles

### Line breaking

Certain characters in Japanese should not come at the end of a line, certain characters should not come at the start of a line, and some characters should never be split up across two lines. These rules are called [Kinsoku Shori 禁則処理](https://en.wikipedia.org/wiki/Line_breaking_rules_in_East_Asian_languages#Line_breaking_rules_in_Japanese_text_(Kinsoku_Shori):

simplified:

| Class | Can't begin a line | Can't finish a line |
|-------|--------------------|---------------------|
| small _kana_ | ぁぃぅぇぉっ... |                  |
| parentheses  | ）〉》】...     | （〈《【...        |
| quotations   | 」』”...       | 「『“...           |
| punctuation  | 、。・！？...   |               |

### Text segmentation

Written Japanese uses no spaces and little punctuation to delimit words. Readers instead depend on grammatical cues (e.g. Japanese, particles and verb endings), the relative frequency of character combinations, and semantic context, in order to determine what words have been written. This is a non trivial problem which is often solved by applying machine learning algorithms. Without a careful approach, breaks can occur randomly and usually in the middle of a word. This is an issue with typography on the web and results in a degradation of readability.

### Zabon ??? - The name

I made a couple of assumptions when choosing the name:
1. 🍊 The original algorithm name **Mikan** might be transscription of 蜜柑, a Japanese citrus fruit (Mandarin, Satsuma)
2. There already is a gem called [mikan](https://rubygems.org/gems/mikan), didn't want to go for **mikan_ruby** or similar b/c of autoloading
3. 🍇 My guess is the original author chose this name, b/c he was searching for something simpler then Google's **Budou** (葡萄)
4. 🔪 Both fruits have in common, that they can be easily split apart in segments
5. So I was searching for another fruit that can be easily split apart, what can be split better apart than a Pomelo (文旦, ぶんたん) -  **Zabon** (derived from Portoguese: zamboa)

Who knows if that's how it was 🤷🏻‍♂️😂.

## The Algorithm

TODO:

## Other solutions
### [Google Budou]((https://github.com/google/budou)

Budou is a python library, which uses word segmenters to analyze input sentences. It can  concatenate proper into meaningful chunks utilizing part-of-speech tagging and other syntactic information. Processed chunks are wrapped in a SPAN tag. Depending on the text segmentation algorithm used, it also has support for Chinese & Korean. Since this library is written in Python, it cannot be used simply used in Ruby, PHP, or Node.js.

#### Text segmenter backends
You can choose different segmenter backends depending on the needs of your environment. Currently, the segmenters below are supported.

* [Google Cloud Natural Language API](https://cloud.google.com/natural-language/): external API calls, can be costly
* [MeCab](https://taku910.github.io/mecab/): Japanese POS tagger & morphological analyzer with lots of language bindings, e.g. also used in Google Japanese Input and Japanese Input on Mac OS X
* [TinySegmenter](http://chasen.org/~taku/software/TinySegmenter/): extremely compact word separation algorithm in Javascript which produces MeCab compatible word separation without depending on external APIs, no dictionaires, classifies input

[TinySegmenter](http://chasen.org/~taku/software/TinySegmenter/) is an extremely compact word separation algorithm in Javascript which produces MeCab compatible word separation without depending on external APIs. It classifies the input by using entities like characters, N-Grams, Hiragana, Katakana (Japanese phonetic lettering system / syllabaries) and their combinations as features to determine whether a character is preceded by a word boundary. A [Naive Bayes]((https://towardsdatascience.com/naive-bayes-explained-9d2b96f4a9c0) model was trained using the [RWCP corpus](http://research.nii.ac.jp/src/en/list.html) and to make that model even more compact Boosting was used for [L1 norm regularization](https://blog.mlreview.com/l1-norm-regularization-and-sparsity-explained-for-dummies-5b0e4be3938a). Basically it compresess the model and get rid off redundant features as much as possible.

## Resources

* [Regular Expressions for Japanese characters](https://gist.github.com/terrancesnyder/1345094)
* [Word breaking in Japanese is Hard](https://docs.microsoft.com/en-us/archive/blogs/jonasbar/word-breaking-japanese-is-hard)
* [mikan.sharp](https://github.com/YoungjaeKim/mikan.sharp)
* [mikan.php](https://github.com/sters/mikan.php)
* [Kinsoku - Japanese line breaking rules for LaTeX](https://github.com/jamesohortle/kinsoku)
* [Kuromoji - Japanese morphological analyzer written in Java](https://www.atilika.org/)
* [WrapText CJK - line breaking rules in Lua](https://github.com/subsoap/wraptext)
* [TinySegmenter - Ruby Port](https://github.com/6/tiny_segmenter)
