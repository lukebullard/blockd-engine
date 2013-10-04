SOURCES=BD_ReadDump.bmx Testing/CreateTestDump.bmx
EXES=$(SOURCES:.bmx=.exe)

all: $(SOURCES)
	

$(SOURCES): $(EXES)
	

clean:
	find . -name '.bmx' -print0 | xargs -0 rm -rf
	find . -iname "*.exe" -print0 | xargs -0 rm
	
%.exe:
	bmk makeapp -a -r -t console -o $@ $(basename $@).bmx
	bmk makeapp -a -d -t console -o $(dir $@)/debug_$(notdir $@) $(basename $@).bmx

.PHONY: all clean
	