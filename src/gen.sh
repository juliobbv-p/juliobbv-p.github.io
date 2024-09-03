# Requires showdown (markdown to HTML generator)
# https://github.com/showdownjs/showdown/wiki/CLI-tool
# brew install nodejs
# npm install showdown -g

rm -rf ../css
mkdir ../css
rm -rf tmp
mkdir tmp
rm -rf ../pics
cp -R pics ../

for i in *.css; do cp "$i" "../css/$i"; done

for i in *.md; do
    [ -f "$i" ] || break
    html="${i%.*}.html"
    echo "Generating $html from markdown"
    showdown makehtml -q -p github -i $i -o tmp/$html
    cat template_header.txt "tmp/$html" template_footer.txt > ../$html

    # Mark current navigation item
    orig=href="\"$html\""
    current=href="\"$html\""class=\"current\"
    sed -i '' -e "s/$orig/$current/g" ../$html
done

rm -rf tmp