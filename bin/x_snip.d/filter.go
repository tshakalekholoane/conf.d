func filter[T any](a []*T, f func(v *T) bool) []*T {
	i := 0
	for _, v := range a {
		if !f(v) {
			a[i] = v
			i++
		}
	}
	clear(a[i:])
	return a[:i]
}
