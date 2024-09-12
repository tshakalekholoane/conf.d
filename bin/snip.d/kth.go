func part[T cmp.Ordered](a []T, l, r int) int {
	i, j := l, r+1
	v := a[l]
	for {
		i++
		for ; a[i] < v; i++ {
			if i == r {
				break
			}
		}
		j--
		for ; v < a[j]; j-- {
			if j == l {
				break
			}
		}
		if i >= j {
			break
		}
		a[i], a[j] = a[j], a[i]
	}
	a[l], a[j] = a[j], a[l]
	return j
}

func kth[T cmp.Ordered](a []T, k *int) []T {
	n := len(a)
	rand.Shuffle(n, func(i, j int) { a[i], a[j] = a[j], a[i] })
	l, r := 0, n-1
	for r > l {
		i := part(a, l, r)
		if i > k {
			r = i - 1
		} else if i < k {
			l = i + 1
		} else {
			*k = a[i]
			return a
		}
	}
	*k = a[l]
	return a
}
