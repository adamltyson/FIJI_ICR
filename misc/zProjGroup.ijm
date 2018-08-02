// Adam Tyson|08/01/2018|adam.tyson@icr.ac.uk
// adapted from macro written by Ved Sharma (http://imagej.1557.x6.nabble.com/Batch-Z-Projection-td3686091.html)
//
path = getDirectory("Choose the directory containing images"); 
filename = getFileList(path); 
newDir = path + "MaxProjections" + File.separator; 
if (File.exists(newDir)) 
   exit("Destination directory already exists - please delete it and try again"); 
File.makeDirectory(newDir); 
for (i=0; i<filename.length; i++) { 
        if(endsWith(filename[i], ".tif")) { 
                open(path+filename[i]); 
                run("Grouped Z Project...", "projection=[Max Intensity] group=8"); // change this line for different number of z steps (e.g. "group=N").
                saveAs("tiff", newDir + getTitle); 
                close(); close(); 
        } 
} 
