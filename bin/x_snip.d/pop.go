func pop[T any](a []T) (T, []T) {
	last := len(a) - 1
	v := a[last]
	a[last] = *new(T)
	a = a[:last]
	return v, a
}
