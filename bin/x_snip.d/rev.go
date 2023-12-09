func rev[T any](a []T) {
	for n, i := len(a), 0; i < n/2; i++ {
		j := n - 1 - i
		a[i], a[j] = a[j], a[i]
	}
}
