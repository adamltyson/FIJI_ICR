// convert16bit.ijm
//
// Macro to load all files in a folder (and subfolders)
// Scale (just by halving intensity)
// Convert to 16 bit
// Save

// Adam Tyson | 2018-03-20 | adam.tyson@icr.ac.uk
// adapted from "BatchProcessFolders" *https://imagej.nih.gov/ij/macros/BatchProcessFolders.txt) and a macro written by Ved Sharma (http://imagej.1557.x6.nabble.com/Batch-Z-Projection-td3686091.html) and "BatchProcessFolders" *https://imagej.nih.gov/ij/macros/BatchProcessFolders.txt)


   dir = getDirectory("Choose a Directory ");
   setBatchMode(true);
   count = 0;
   countFiles(dir);
   n = 0;
   processFiles(dir);
   //print(count+" files processed");

   function countFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              countFiles(""+dir+list[i]);
          else
              count++;
      }
  }

   function processFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              processFiles(""+dir+list[i]);
          else {
             showProgress(n++, count);
             path = dir+list[i];
             processFile(path);
          }
      }
  }

  function processFile(path) {
       if (endsWith(path, ".tif")) {
           open(path);
           newFilename=replace(path,".tif","_16bit.tif");
           saveAs("tiff", newFilename);
           run("Divide...", "value=2 stack");
           run("16-bit");
           saveAs("tiff", newFilename);
           run("Close All");
           run("Collect Garbage");​
      }
  }
