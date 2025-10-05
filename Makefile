# a simple Makefile

SENDER = termux-share -a send
VIEWER = viewpdf

CHAPTERS := $(wildcard chapter_*/chapter.tex)
WORKS := $(wildcard work_*/work.tex)

SECTIONS := $(wildcard chapter_*/section_*/section.tex) $(wildcard work_*/section_*/section.tex)

TIKZPICS := $(wildcard */tikzpics/*.tex)

ABSTRACT := abstract_template.tex abstract.tex

REFERENCES := references.bib

# PRJPLAN := prjplan.tex

BUILD_FILES := $(wildcard *.aux *.bbl *.bcf *.blg *.lof main.log *.lot main.pdf *.run.xml *.toc *.tstp)

build: main.pdf view

fast:
	lunatikz build main.tex
	pdflatex -shell-escape -halt-on-error main.tex
	$(VIEWER) main.pdf

fast_nolt:
	pdflatex -shell-escape -halt-on-error main.tex
	$(VIEWER) main.pdf

force:
	lunatikz build main.tex
	pdflatex -shell-escape -halt-on-error main.tex
	biber main
	pdflatex -shell-escape -halt-on-error main.tex
	$(VIEWER) main.pdf

main.pdf: main.tex preamble.tex colorscheme.sty $(ABSTRACT) $(CHAPTERS) $(SECTIONS) $(WORKS) $(TIKZPICS) $(REFERENCES)
	lunatikz build main.tex
	pdflatex -shell-escape -halt-on-error main.tex
	biber main
	pdflatex -shell-escape -halt-on-error main.tex

clean:
	rm $(BUILD_FILES)

view:
	$(VIEWER) main.pdf

send:
	$(SENDER) main.pdf

.PHONY: view build fast force clean
