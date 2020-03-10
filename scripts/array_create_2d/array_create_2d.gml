///@func array_create_2d(w,h,val)
///@args w,h,val
var _a;
for(var i = 0; i < argument[0]; i++) {
	for(var m = 0; m < argument[1]; m++) {
		_a[i, m] = argument[2];
	}
}
return _a;