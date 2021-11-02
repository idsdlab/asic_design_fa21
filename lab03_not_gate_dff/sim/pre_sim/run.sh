vcs \
-R \
-debug_acc+all -kdb -debug_region+cell+encrypt \
+neg_tchk \
+maxdelays \
+lint=TFIPC-L \
-timescale=1ns/1ps \
-f run.f \
-l gate_sim.log
