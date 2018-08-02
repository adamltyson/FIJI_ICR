//// infinity_to_0.ijm 
// Adapted from http://imagej.1557.x6.nabble.com/Infinity-values-td3686956.html
// Adam Tyson | adam.tyson@icr.ac.uk | 2017-07-12

// Replaces infinity values with zeros in a stack.
Infinity = 1.0/0.0; 
targetValue = Infinity;
repValue = 0.0;
h = getHeight(); 
w = getWidth(); 
z = nSlices();

for(z=1; z<=nSlices;z++){ 
 setSlice(z); 
	for (y = 0; y < h; y++){ 
			for ( x = 0; x < w;  x++){ 
					p = getPixel(x,y); 
					if (p == targetValue){ setPixel(x,y,repValue); } 
			} 
	} 
}