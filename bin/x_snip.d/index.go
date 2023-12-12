func index[T cmp.Ordered](a []T, of T) int {
	i, j := 0, len(a)
	for i < j {
		m := int(uint(i+j) >> 1)
		v := a[m]
		if of < v {
			j = m
		} else if of > v {
			i = m + 1
		} else {
			return m
		}
	}
	return -1
}
