// "zProj_Dir"
//
// Adam Tyson|12/01/2018|adam.tyson@icr.ac.uk
// adapted from "BatchProcessFolders" *https://imagej.nih.gov/ij/macros/BatchProcessFolders.txt) and a macro written by Ved Sharma (http://imagej.1557.x6.nabble.com/Batch-Z-Projection-td3686091.html) and "BatchProcessFolders" *https://imagej.nih.gov/ij/macros/BatchProcessFolders.txt)
//
// This macro processes all files in subdirectories. All images in each subdirectory
// are opened, and a grouped Z projection is performed.


   dir = getDirectory("Choose a Directory ");
   setBatchMode(true);
   count = 0;
   countFiles(dir);
   n = 0;
   processFiles(dir);

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
            maxProj(path);
          }
      }
  }

   function maxProj(path) {
            if (matches(path, ".*000000000.*000.tif")) {
            run("Image Sequence...", "open=[path] file=.tif sort");
            run("Grouped Z Project...", "projection=[Max Intensity] group=8"); // change this line for different number of z steps (e.g. "group=N").
            newFilename=replace(path,".tif","_maxProj.tif");
            saveAs("tiff", newFilename);
            run("Close All");
            run("Collect Garbage");​
        }
    }
