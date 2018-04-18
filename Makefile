# from https://stackoverflow.com/a/37076801/9383522

PACKAGE_DIR = ~/.st
PACKAGE_SPEC = package.xml
PACKAGE_FILE = $(PACKAGE_DIR)/sched.star
PACKAGE_SRC = \
  Product.st \
  Entry.st \
  Schedule.st

$(PACKAGE_FILE): $(PACKAGE_SRC) $(PACKAGE_SPEC)
	gst-package -t ~/.st $(PACKAGE_SPEC)
