general-tools/matlab-tools
=============

## Description
General MATLAB code used by the lab.  

## Code
- Manipulate CSV files:
  - [**readCsv.m**](./readCsv.m): Reads CSV files into a cell array (1xnColumns) of structures with fields header (first cell in column) and col (cell array of other cells in column).
  - [**mergeStructures.m**](./mergeStructures.m): Merges structures of the form readCsv outputs. Straightforward way to merge CSV files.
  - [**writeCsv.m**](./writeCsv.m): Saves CSV files based on structure of the form readCsv outputs.
  - [**correctCsv.m**](./correctCsv.m): Removes quotation marks from CSV files.
- Manipulate strings:
  - [**cellstrfind.m**](./cellstrfind.m): Determines if any strings within cell array are within another cell array of strings.
  - [**cleanPath.m**](./cleanPath.m): Removes extraneous forward slashes from paths.
  - [**stringReplace.m**](./stringReplace.m): Performs string replacements throughout cell arrays, structures, etc.
- Miscellaneous:
  - [**hourToc.m**](./hourToc.m): Presents results from tic/toc in more readable format.
  - [**isNumberOrNan.m**](isNumberOrNan.m): Determines if string input is a number (or 'NaN') or not.
  - [**makeDirectoryTree.m**](./makeDirectoryTree.m): Makes every folder in path.
  - [**python.m**](./python.m): Modified version of Matlab's [perl.m](http://www.mathworks.com/help/matlab/ref/perl.html) to run Python commands.
  - [**removeEmptyCells.m**](./removeEmptyCells.m): Cleans cell arrays and structures of the form readCsv outputs of empty cells.
  - [**smartError.m**](./smartError.m): Reports try/catch errors in a readable format.

<!-- Start infrastructure -->
## [general-tools](https://github.com/TCANLab/general-tools)
- [bash-tools](https://github.com/TCANLab/general-tools/tree/master/bash-tools)
- [matlab-tools](https://github.com/TCANLab/general-tools/tree/master/matlab-tools)
- [python-tools](https://github.com/TCANLab/general-tools/tree/master/python-tools)  
  
<!-- End infrastructure -->
