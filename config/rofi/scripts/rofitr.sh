#!/usr/bin/env bash
# Copyright (C) 2019 Yusuf Aktepe <yusuf@yusufaktepe.com>

## Set defaults
SOURCE="ja"               # source language code
TARGET="en"               # translation language code
# ENGINE="google"           # google, yandex or bing
# LOCALE="en"               # translator language ($LANG var. by default)
# SPEAK_SOURCE="false"      # speak the source (true/false)
# SPEAK_TRANSLATION="false" # speak the translation (true/false)

## Rofi general options
# leave these empty or comment out to use system defaults:
# FONT="mono 12"
WIDTH="50"
LOCATION="0"
# YOFFSET="-20"

# use alternative config and theme
# CONFIG="~/.config/rofi/translate-config.rasi"
# THEME="/usr/share/rofi/themes/lb.rasi"

## Rofi required options
HIST_LINES="5" # lines to show for history mode
RES_LINES="100"  # limit output to screen height
PROMPT_TR=" "
PROMPT_HIST=" history"
PROMPT_DEL="﯊ delete"
CLR_RESULT="#ffffff" # text color for translation
CLR1="#5294e2"
CLR2="#1d2021"

HIST="${XDG_DATA_HOME:-~/.local/share}/rofi/rofitr_history"
mkdir -p "$(dirname "$HIST")"

help() {
cat <<EOF
# <u>Translate with defaults</u>
> <span background="$CLR1" foreground="$CLR2"><b><i>text</i></b></span>
# <u>Override default SOURCE and TARGET</u>
> <span background="$CLR1" foreground="$CLR2"><b>en:es <i>text</i></b></span>
# <u>Auto-detect SOURCE</u>
> <span background="$CLR1" foreground="$CLR2"><b>:en <i>text</i></b></span>
<s>                                             </s>
<u>Actions:</u>
<span foreground="$CLR1"><b>!e</b></span> <i>word</i> => show examples for "word"
<span foreground="$CLR1"><b>!s</b></span> <i>text</i> => speak the "text"
<span foreground="$CLR1"><b>!!</b></span>      => show last translation
<span foreground="$CLR1"><b>!!e</b></span>     => show examples for last translation
<span foreground="$CLR1"><b>!!s</b></span>     => speak last translation
<span foreground="$CLR1"><b>!</b></span>       => select and translate from history
<span foreground="$CLR1"><b>!d</b></span>      => select and remove from history
<span foreground="$CLR1"><b>!dd</b></span>     => clear history (in delete mode)
<s>                                             </s>
<u>Command line:</u>
$ rofitr :ru <i>text</i> <span foreground="$CLR1">=> </span>Translate into Russian
$ rofitr -s       <span foreground="$CLR1">=> </span>Translate from primary selection
EOF
}

rofi_cmd() {
	[ -n "$CONFIG" ] && params+=(-config "$CONFIG")
	[ -n "$THEME" ] && params+=(-theme "$THEME")
	[ -n "$WIDTH" ] && params+=(-width "$WIDTH")
	[ -n "$LOCATION" ] && params+=(-location "$LOCATION")
	[ -n "$YOFFSET" ] && params+=(-yoffset "$YOFFSET")
	[ -n "$FONT" ] && params+=(-font "$FONT")

	rofi -dmenu -i "${params[@]}" "$@"
}

crow_cmd() {
	[ -n "$ENGINE" ] && crowparams+=(-e "$ENGINE")
	[ -n "$LOCALE" ] && crowparams+=(-l "$LOCALE")
	[ "$SPEAK_TRANSLATION" = "true" ] && crowparams+=(-p)
	[ "$SPEAK_SOURCE" = "true" ] && crowparams+=(-u)

	crow "${crowparams[@]}" "$@"
}

format() {
	clean="s/^[\t]$//;/^$/d;s/\&/\&amp\;/g;s/</\&lt\;/g;s/>/\&gt\;/g;/ - translation options:$/d"
	bold="s/^\(auxiliary verb\|abbreviation\|adjective\|adverb\|article\|conjunction\|contraction\|exclamation\|interjection\|noun\|particle\|prefix\|preposition\|pronoun\|suffix\|symbol\|verb\)$/<b>&<\/b>/"
	trl="s/^\[ .*-\&gt\;.* \]$/<span foreground=\"$CLR1\"><i>&<\/i><\/span>/"
	case "$1" in
		ex) sed -e "$clean" -e "$bold" -ne '/- examples:/,$p' | head -n $RES_LINES ;;
		sel) sed -e "$clean" -e '/ - examples:$/d' -e "$bold" -e "$trl" | sed -z 's/\n*(/ (/' | head -n $RES_LINES ;;
		*) sed -e "$clean" -e '/- examples:$/Q' -e "$bold" -e "$trl" | sed -z 's/\n*(/ (/' | head -n $RES_LINES
	esac
}

cklang() {
	lslang=(
		"af" "sq" "am" "ar" "hy" "az" "eu" "ba" "be" "bn" "bs" "bg" "ca" "yue" "ceb"
		"zh-CN" "zh-TW" "co" "hr" "cs" "da" "nl" "en" "eo" "et" "fj" "fil" "fi" "fr"
		"fy" "gl" "ka" "de" "el" "gu" "ht" "ha" "haw" "he" "mrj" "hi" "hmn" "hu" "is"
		"ig" "id" "ga" "it" "ja" "jw" "kn" "kk" "km" "tlh" "tlh-Qaak" "ko" "ku" "ky" "lo"
		"la" "lv" "apc" "lt" "lb" "mk" "mg" "ms" "ml" "mt" "mi" "mr" "mhr" "mn" "my" "ne"
		"no" "ny" "pap" "ps" "fa" "pl" "pt" "pa" "otq" "ro" "ru" "sm" "gd" "sr-Cyrl"
		"sr-Latin" "st" "sn" "sd" "si" "sk" "sl" "so" "es" "su" "sw" "sv" "tl" "ty" "tg"
		"ta" "tt" "te" "th" "to" "tr" "udm" "uk" "ur" "uz" "vi" "cy" "xh" "yi" "yo" "yua"
	)
	printf '%s\n' "${lslang[@]}" | grep -x "$1"
}

esc() { sed 's|[][\\/.*^$]|\\&|g' <<< "$1" ;}

append_hist() {
	sed -i "/^$(esc "$input")$/d" "$HIST"
	printf '%s\n' "$input" >> "$HIST"
}

return_result() {
	input="$(rofi_cmd -p "$PROMPT_TR" -l 0 -mesg "<span color='$CLR_RESULT'>$result</span>")"
}

[ -n "$*" ] && input="$*" || input="$(rofi_cmd -p "$PROMPT_TR" -l 0)"

while [ -n "$input" ]; do
	case "$input" in
		"?")	input="$(rofi_cmd -p "Usage" -l 0 -mesg "<span color='$CLR_RESULT'>$(help)</span>")" ;;
		!)	input="$(tac "$HIST" | rofi_cmd -p "$PROMPT_HIST" -l "$HIST_LINES")"
			[ "$input" = "!" ] && input="$(rofi_cmd -p "$PROMPT_TR" -l 0)" ;;
		!!)	input=$(tail -n1 "$HIST") ;;
		!!e)	input=$(printf "!e %s" "$(tail -n1 "$HIST")") ;;
		!!s)	input=$(printf "!s %s" "$(tail -n1 "$HIST")") ;;
		!d)	pattern="$(tac "$HIST" | rofi_cmd -p "$PROMPT_DEL" -l "$HIST_LINES")"
			case "$pattern" in
				!) input="$(rofi_cmd -p "$PROMPT_TR" -l 0)" ;;
				!dd) printf '' > "$HIST" && exit 0 ;;
				"") exit 0 ;;
				*) sed -i "/^$(esc "$pattern")$/d" "$HIST"
			esac ;;
		??*:??*)
			SOURCE=$(cklang "$(echo "$input" | awk -F':' '{print $1}')")
			TARGET=$(cklang "$(echo "$input" | awk -F'[:| ]' '{print $2}')")
			input=$(echo "$input" | cut -d' ' -f2-)
			result=$(crow_cmd -s "${SOURCE:-en}" -t "${TARGET:-tr}" -- "$input" | format)
			unset SOURCE TARGET
			append_hist; return_result ;;
		:??*)
			TARGET=$(cklang "$(echo "$input" | awk -F'[:| ]' '{print $2}')")
			input=$(echo "$input" | cut -d' ' -f2-)
			result=$(crow_cmd -t "${TARGET:-tr}" -- "$input" | format)
			unset TARGET
			append_hist; return_result ;;
		!e*)
			input=$(echo "$input" | cut -d' ' -f2-)
			result=$(crow_cmd -- "$input" | format ex)
			append_hist; return_result ;;
		!s*)
			input=$(echo "$input" | cut -d' ' -f2-)
			result=$(SPEAK_SOURCE="true" crow_cmd -- "$input" | format sel)
			append_hist; return_result ;;
		-s)
			input=$(xclip -o | tr -d '\n'); [ -z "$input" ] && exit
			result=$(crow_cmd -t "${TARGET:-tr}" -- "$input" | format)
			append_hist; return_result ;;
		*)
			result=$(crow_cmd -s "${SOURCE:-en}" -t "${TARGET:-tr}" -- "$input" | format)
			append_hist; return_result ;;
	esac
done
