# Essential Git Commands

Here are some of the git commands that will serve you well working professionally on team based projects.

## Creating a branch

```
> git checkout -b <branchname>
```

## Delete a branch

```
> git branch -D <branchname>
```

## Committing a change

```
> git add .
or
> git add -p (incremental)
then
> git commit -m "Commit message"
```

## Pushing a change

Will push your change up to your repos. If your remove hasn't been setup you may need to do that first.

```
> git push
```

If your history has diverged or changed from your remote you can force a push.

```
> git push --force
```

> Note: This will override whatever changes are currently in your remove. So use cautiously, and never on a shared branch.

## Essential Vi commands

Vi is found on every unix box in the world, and is super handy to know. Here are the basically you'll need to use this when working from the command line terminal on your Mac.

```
i - insert mode
:wq - write quit
:q! - force quit
dd - delete line
dd # - delete # number of lines
p - put delete lines
a - append
o - new line insert
x - delete character
esc - get out of insert mode
```

## How to write a good commit message

Follow these maxims when writing a commit message.

###  The Subject Line

- Limit of 50 characters (should be short and sweet, to the point)
- No capitalization, no period, one sentence
- Should be written in the imperative, not past, or future tense
 - Not “Painting the fence” or “Painted the fence”. “Paint the fence”.
 - "Make xyz do abc" instead of "This makes xyz do abc" or “Changed xyz to do abc”
 - “Fix bug”, not “Fixes bug” or “Fixed bug”
- Completes the sentence **"This commit will ......"**

### Examples of good subject lines

- fix: make the cached role coherent with the actual one
- fix: fix rewind behaviour when paused
- perf: make source.indexOf(bytestring) significantly faster
- feat: add loading states for bulk operations
 
## Resetting your branch

To this when you've screwed up, and want to reset.

```
> git reset --hard <SHA>
```

## Force push

This will reset everything on your remote branch. Use with caution as it will override any other changes others have made. So don't do this on shared branches.

```
> git push --force (optional)
```

## Squash commits with rebase

This is how you can make commits and squash them into one.

```
> git log (note SHA you want to squash to)
> git rebase -i <SHA you want to squash to>
```

You will now be in Vi. Squash by going...

Then go...

And then...

You can now push these remotely.

```
> git push
```

Or, if you want to override changes you have already made (and you are the only one on this branch), you can overwrite your remove with:

```
> git push --force
```


## Resetting

If you've made a mistake and you want to go back and start again from a previous commit, find the place you want to go back to:

```
> git log (note SHA)
> git reset --hard SHA
```

And optional force push if you want to override what's in your remote. Note: Just make sure this is a non-shared branch else people will get upset that you overrode their changes.

```
> git push --force
```

## How to create an MR

MR (Merge Requests) are when you are working on a team, and you want to merge your changes with others. This is called a MR, and it's an opportunity for others to review your code before merging your changes in.

MRs are typically created on the tool hosting your repos (i.e. gitlab). And here people will leave comments, make suggestions, and generally try to help you improve your code.

Once your MR is approved (number of approvals required veries by team, typically x2), you will then be able to merge your changes.

 
### Links that help

- [UIAlertController](https://developer.apple.com/documentation/uikit/uialertcontroller)
- [UIAlertControllerExample](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIAlertController/UIAlertController.md)
