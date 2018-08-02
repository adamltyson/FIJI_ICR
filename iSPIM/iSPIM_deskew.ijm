// Macro to deskew MLS stage scans.
// Adam Tyson | adam.tyson@icr.ac.uk | 2018-0524

// Adapted from macro by Min Guo & Hari Shroff (2016)
// http://dispim.org/software/imagej_macro

// Define the deskew parameters, and choose a directory containing skewed images (.tif)
// All images in the directory will be deskewed, and saved to /deskew

// Define deskew ////////////////////////////////

while (nImages>0) {
          selectImage(nImages); 
          close(); 
      }
print("Set parameters...");
Dialog.create("Image_Shifting");
Dialog.addMessage("\n");
items = newArray("StageDistance","Z_spacing");
Dialog.addRadioButtonGroup("Set Slice Step Type", items, 1, 2, "Z_spacing");
Dialog.addMessage("\n");
Dialog.addNumber("Distance: interval", 0.500,3,6,"um");
Dialog.addNumber("Distance: pixelsize", 0.1625,4,6,"um");
Dialog.addMessage("Set Shifting Direction");
items = newArray("Left2Right", "Right2Left");
Dialog.addChoice("Direction A", items, "Right2Left");
Dialog.addMessage("\n");
items = newArray("Default", "Custom");
Dialog.addChoice("File Naming Convention", items, "Default");
//Dialog.addMessage("Default: specify main Directory");
//Dialog.addMessage("Custom: specify all input and out paths");
Dialog.show();


sd1 = Dialog.getChoice();
if(sd1=="Left2Right")
	d1 = 1;
else
	d1 = -1;

stepType = Dialog.getRadioButton();
interval = Dialog.getNumber();
pixelsize = Dialog.getNumber();
if(stepType=="StageDistance")
	shiftStep = interval/1.414/pixelsize;
else
	shiftStep = interval/pixelsize;

inputDir = getDirectory("Choose input directory");
outputDir = inputDir+"/deskew";

filename = getFileList(inputDir);

File.makeDirectory(outputDir);

// Deskew ////////////////////////////////

setBatchMode(true); 
print("Deskewing...");
for (i=0; i<filename.length; i++) { 
        if(endsWith(filename[i], ".tif")) { 
	dir = inputDir+filename[i];
	deskew(dir,shiftStep,d1);
	
  	saveAs("Tiff", outputDir+"/"+getTitle+".tif");
  	close(); 
}
}

print("Deskewing completed !");

// deskew function
function deskew(dir,shiftStep,d){

	open(dir);
	sx = getWidth();
	sy = getHeight();
	slice = nSlices();

	ID = getImageID();
	sx = round(slice*shiftStep) + sx + 10;
	if(d==1)
		run("Canvas Size...", "width=sx height=sy position=Center-Left");
		// run("Canvas Size...", "width=sx height=sy position=Center-Left zero");

	else
		run("Canvas Size...", "width=sx height=sy position=Center-Right");		
		// run("Canvas Size...", "width=sx height=sy position=Center-Right zero");
	for (j=1;j<=slice;j++)
	{
		setSlice(j);
		shift = j*shiftStep*d;
		run("Translate...", "x=shift y=0 interpolation=Bilinear slice");
	}
}

