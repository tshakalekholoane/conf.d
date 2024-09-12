func dequeue[T any](a []T, v *T) []T {
	if v != nil {
		*v = a[0]
	}
	a[0] = *new(T)
	a = a[1:]
	return a
}
