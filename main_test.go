package main

import (
	"testing"
	"time"

	"github.com/moov-io/base"
	"github.com/moov-io/base/log"

	"github.com/stretchr/testify/require"
)

func TestRunner(t *testing.T) {
	nyc, _ := time.LoadLocation("America/New_York")
	when := time.Date(2021, time.December, 2, 12, 0, 0, 0, nyc)
	rr := &runner{
		logger: log.NewNopLogger(),
		now:    base.NewTime(when),
		args:   []string{"date", "-u"},
	}
	output, err := rr.run()
	require.NoError(t, err)
	require.Contains(t, string(output), "UTC")
}

func TestRunner__Holiday(t *testing.T) {
	nyc, _ := time.LoadLocation("America/New_York")
	when := time.Date(2021, time.July, 4, 12, 0, 0, 0, nyc)
	rr := &runner{
		logger: log.NewNopLogger(),
		now:    base.NewTime(when),
		args:   []string{"date", "-u"},
	}
	output, err := rr.run()
	require.NoError(t, err)
	require.Empty(t, output)
}

func TestRunner__Error(t *testing.T) {
	nyc, _ := time.LoadLocation("America/New_York")
	when := time.Date(2021, time.December, 2, 12, 0, 0, 0, nyc)
	rr := &runner{
		logger: log.NewNopLogger(),
		now:    base.NewTime(when),
		args:   []string{"date", "-invalid"},
	}
	output, err := rr.run()
	require.Error(t, err)
	require.Empty(t, output)
}
