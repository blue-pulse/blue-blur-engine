function __resnip_transition_key(_from, _to) {
	gml_pragma("forceinline");
	return string(_from.__id) + ">" + string(_to.__id);
}
