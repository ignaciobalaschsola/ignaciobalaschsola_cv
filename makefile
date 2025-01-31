# Define file names
TARGET = BALASCHSOLA
SRC_DIR = src
BUILD_DIR = build
TEX_FILE = content.tex
CLASS_FILE = altacv.cls

# Compiler and flags
LATEXMK = latexmk
PDFLATEX = pdflatex -interaction=nonstopmode

# Default rule: compile the CV
all: $(BUILD_DIR)/$(TARGET).pdf

# Compile the LaTeX document
$(BUILD_DIR)/$(TARGET).pdf: $(SRC_DIR)/$(TEX_FILE) $(SRC_DIR)/$(CLASS_FILE)
	@mkdir -p $(BUILD_DIR)  # Ensure build directory exists
	cp $(SRC_DIR)/$(CLASS_FILE) $(BUILD_DIR)/  # Copy class file
	$(LATEXMK) -pdf -pdflatex="$(PDFLATEX)" -output-directory=$(BUILD_DIR) $(SRC_DIR)/$(TEX_FILE)
	mv $(BUILD_DIR)/content.pdf $(BUILD_DIR)/$(TARGET).pdf  # Rename final output

# Clean up auxiliary files
clean:
	$(LATEXMK) -c -output-directory=$(BUILD_DIR) $(SRC_DIR)/$(TEX_FILE)
	rm -rf $(BUILD_DIR)/*.log $(BUILD_DIR)/*.aux $(BUILD_DIR)/*.fls $(BUILD_DIR)/*.fdb_latexmk

# Fully remove all generated files
purge: clean
	rm -rf $(BUILD_DIR)

# Open the compiled PDF (Mac/Linux)
view:
	open $(BUILD_DIR)/$(TARGET).pdf