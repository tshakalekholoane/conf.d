func pop[T any](a []T, v *T) []T {
	last := len(a) - 1
	if v != nil {
		*v = a[last]
	}
	a[last] = *new(T)
	a = a[:last]
	return a
}
