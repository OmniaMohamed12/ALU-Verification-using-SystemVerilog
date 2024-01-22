all:	clean comp run
clean:
	\rm -rf simv* csrc* *.log
comp:
	vcs  -sverilog  -R -cm line+tgl+branch+cond -f rtl.f  -l comp.log 
run:
	./simv -l run.log -o out
