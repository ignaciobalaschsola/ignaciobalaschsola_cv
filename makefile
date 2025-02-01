# Define file paths
SRC_DIR = src
BUILD_DIR = build
TEX_FILE = content.tex
CLASS_FILE = altacv/altacv.cls
IMG_FILE = profile.jpg

# Compiler and flags
LATEXMK = latexmk
PDFLATEX = pdflatex -interaction=nonstopmode

# Default rule: compile the CV
all: $(BUILD_DIR)/content.pdf

# Compile the LaTeX document inside build/
$(BUILD_DIR)/content.pdf: $(SRC_DIR)/$(TEX_FILE) $(SRC_DIR)/$(CLASS_FILE) $(SRC_DIR)/$(IMG_FILE)
	@mkdir -p $(BUILD_DIR)                      # Ensure build directory exists
	cp $(SRC_DIR)/$(TEX_FILE) $(BUILD_DIR)/     # Copy content.tex
	cp $(SRC_DIR)/$(CLASS_FILE) $(BUILD_DIR)/   # Copy altacv.cls
	cp $(SRC_DIR)/$(IMG_FILE) $(BUILD_DIR)/     # Copy profile.jpg

	cd $(BUILD_DIR) && $(LATEXMK) -pdf -pdflatex="$(PDFLATEX)" $(TEX_FILE)

# Clean up auxiliary files (but keep the PDF)
clean:
	$(LATEXMK) -c -output-directory=$(BUILD_DIR) $(BUILD_DIR)/$(TEX_FILE)
	rm -rf $(BUILD_DIR)/*.log $(BUILD_DIR)/*.aux $(BUILD_DIR)/*.fls $(BUILD_DIR)/*.fdb_latexmk
	rm -rf $(BUILD_DIR)/*.out $(BUILD_DIR)/*.synctex.gz

# Fully remove all generated files
purge: clean
	rm -rf $(BUILD_DIR)

# Open the compiled PDF (Mac/Linux)
view:
	open $(BUILD_DIR)/content.pdf