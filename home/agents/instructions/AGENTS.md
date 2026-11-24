## Tools

If you're going to use the command in the first column, please use the preferred command in the second, "Preferred" column.

| Command | Preferred |
| ------- | --------- |
| `find`  | `fd`      |
| `grep`  | `rg`      |
| `git`   | `jj`      |
| `bash`  | `fish`    |

## Jujutsu

Each time that you're about to make changes to the file system and the repository has working copy changes (i.e. `jj status` outputs some modified files) please first create a new change by running `jj new`. When you're done with the feature, make sure that the change has a short and very concise description using `jj describe --message <message>`.

If you're asked to create a GitHub issue or pull request, use something like `gh {issue,pr} create --web --title "<title>" --body "<body>"` so that it's not actually submitted and I can review it in my web browser.

## General

Don't remove or edit comments unless they're factually incorrect, or you have some other good reason to do so.

## Responding

Try to keep the response as short, concise and to the point as possible while. I can always ask follow-up questions if anything is too vague.

When referring to a file, use its full file path from the project root.

When referring to a jujutsu change, make the unique characters bold, just like jj. For example "**yz**xupwzt".
