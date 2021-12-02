package main

import (
	"fmt"
	"os"
	"os/exec"
	"time"

	"github.com/moov-io/base"
	"github.com/moov-io/base/log"
)

func main() {
	logger := log.NewDefaultLogger()

	location := time.UTC
	if ll := os.Getenv("TZ"); ll != "" {
		if loc, err := time.LoadLocation(ll); err != nil {
			logger.Error().LogErrorf("unable to load location: %w", err)
			os.Exit(1)
		} else {
			location = loc
		}
	}

	rr := &runner{
		logger: logger,
		now:    base.Now(location),
		args:   os.Args[1:],
	}
	output, err := rr.run()
	if err != nil {
		os.Exit(1)
	}
	fmt.Printf(string(output))
}

type runner struct {
	logger log.Logger
	now    base.Time
	args   []string
}

func (r *runner) run() ([]byte, error) {
	if !r.now.IsBankingDay() {
		r.logger.Info().Log("skipping since it's not a banking day")
		return nil, nil
	}

	var name string
	var args []string

	if len(r.args) < 1 {
		return nil, r.logger.Error().LogErrorf("no command specified").Err()
	} else {
		name = r.args[0]
	}
	if len(r.args) > 1 {
		args = r.args[1:]
	}

	r.logger.Info().Logf("running %s", name)

	cmd := exec.Command(name, args...)
	cmd.Stderr = os.Stdout

	output, err := cmd.Output()
	if err != nil {
		return nil, r.logger.Error().LogErrorf("problem running %s: %v", name, err).Err()
	}
	return output, nil
}
