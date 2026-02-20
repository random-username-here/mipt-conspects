

###
### Finds chapters (folders with doc.typ) in given folder
###
function find_chapters
{
	for DIR in $(ls $1); do
		if ! [ -f "$DIR/doc.typ" ]; then continue; fi
		echo "$DIR"
	done
}

CMD=$1
shift

case $CMD in
	find_chapters) find_chapters $@ ;;
	*) echo "Unknown command '$CMD'"; exit 1 ;;
esac
