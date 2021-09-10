all: vcs

vcs:
	vcs -full64 -R -debug_acc+all -f run.f
verdi:
	Verdi-SX -f run.f &
clean:
	rm -rf csrc novas.conf novas_dump.log novas.rc simv simv.daidir ucli.key VerdiLog Verdi-SXLog test.fsdb
