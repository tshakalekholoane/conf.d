package sample_package_name

import "testing"

func TestAdd(t *testing.T) {
	tests := []struct {
		inputA, inputB, want int
	}{
		{2, 2, 4},
	}
	for _, test := range tests {
		t.Run("", func(t *testing.T) {
			got := Add(test.inputA, test.inputB)
			if got != test.want {
				t.Errorf("Add(%d, %d) = %d, want %d", test.inputA, test.inputB, got, test.want)
			}
		})
	}
}
