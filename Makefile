BOOKS=alice christmas_carol dracula frankenstein heart_of_darkness life_of_bee moby_dick modest_propsal pride_and_prejudice tale_of_two_cities ulysses

FREQLISTS=$(BOOKS:%=results/%.freq.txt)
PARSEDBOOKS=$(BOOKS:%=*.parsed.txt)
SENTEDBOOKS=$(BOOKS:%=results/%.sent.txt)
ALLBOOKS=$(BOOKS:%=data/%.txt)

all: $(FREQLISTS) $(SENTEDBOOKS) $(PARSEDBOOKS) $(ALLBOOKS)

clean:
	rm -f results/* data/*no_md.txt

%.no_md.txt: %.txt
	python3 src/remove_gutenberg_metadata.py $< $@

data/%.all.no_md.txt: data/%.txt
	src/all_books.sh $^ $@

results/%.freq.txt: data/%.no_md.txt 
	src/freqlist.sh $< $@

results/%.sent.txt: data/%.no_md.txt
	src/sent_per_line.sh $< $@
 
results/%.parsed.txt: results/%.sent.txt
	cat $< > $@
