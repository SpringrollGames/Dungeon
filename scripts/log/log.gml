///@func log(string)
///@param string
ds_list_add(messages, argument0);
if (ds_list_size(messages) > log_size) {
	ds_list_delete(messages, 0);
}