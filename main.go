package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
)

type Repo struct {
	Name string `json:"name"`
}

type Contributor struct {
	Login         string `json:"login"`
	HTMLURL       string `json:"html_url"`
	Contributions int    `json:"contributions"`
}

func fetchJSON(url string, target any) error {
	resp, err := http.Get(url)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return err
	}

	return json.Unmarshal(body, target)
}

func main() {
	org := "Vimothy-s-Vestibule"

	reposURL := fmt.Sprintf(
		"https://api.github.com/orgs/%s/repos",
		org,
	)

	var repos []Repo

	err := fetchJSON(reposURL, &repos)
	if err != nil {
		panic(err)
	}

	contributors := make(map[string]Contributor)

	for _, repo := range repos {
		fmt.Printf("Fetching contributors for repo: %s\n", repo.Name)

		contribURL := fmt.Sprintf(
			"https://api.github.com/repos/%s/%s/contributors",
			org,
			repo.Name,
		)

		var repoContributors []Contributor

		err := fetchJSON(contribURL, &repoContributors)
		if err != nil {
			fmt.Println("Error:", err)
			continue
		}

		for _, c := range repoContributors {
			if existing, ok := contributors[c.Login]; ok {
				existing.Contributions += c.Contributions
				contributors[c.Login] = existing
			} else {
				contributors[c.Login] = c
			}
		}
	}

	fmt.Println("\n Contributors ")

	for _, c := range contributors {
		fmt.Printf(
			"%s (%d contributions)\nProfile: %s\n\n",
			c.Login,
			c.Contributions,
			c.HTMLURL,
		)
	}
}
