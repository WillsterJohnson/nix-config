// @ts-nocheck
import { $ } from "bun";
import fs from "node:fs"; //!
import path from "node:path"; //!

const packageMap = {};

async function main() {
	const foundWorkspaces = new Array<string>();
	for (const workspace of getWorkspaces().map((workspace) => workspace.replace(/\/\*$/, ""))) {
		const dirpath = path.resolve(workspace);
		const subdirs = fs
			.readdirSync(dirpath)
			.filter((file) => fs.statSync(path.resolve(dirpath, file)).isDirectory());
		for (const subdir of subdirs) {
			const file = Bun.file(path.resolve(dirpath, subdir, "package.json"));
			if (!(await file.exists())) continue;
			foundWorkspaces.push(path.resolve(dirpath, subdir));
			const { name } = await file.json();
			packageMap[name] = path.resolve(dirpath, subdir);
		}
	}
	for (const workspace of foundWorkspaces) {
		fs.rmdirSync(path.resolve(workspace, "node_modules"), { recursive: true });
		const dependencies = await readPackageJsonFor(workspace);
		for (const [dependency, version] of Object.entries(dependencies)) {
			if (version === "workspace:*") await workspaceLink(dependency, workspace);
			else await installedLink(dependency, workspace);
		}
	}
}

async function getWorkspaces() {
	let dir = path.resolve(".");
	while (true) {
		const lockfile = path.resolve(dir, "bun.lockb");
		if (Bun.file(lockfile).exists()) break;
		const parent = path.resolve(dir, "..");
		if (parent === dir) throw new Error("No bun.lockb file found in any parent directory");
		dir = parent;
	}
	const packageJson = path.resolve(dir, "package.json");
	const file = Bun.file(packageJson);
	const contents = await file.json();
	return contents.workspaces;
}

async function getLinkPaths(sourceModuleName: string, project: string) {
	const linkpath = path.resolve(project, "node_modules", sourceModuleName);
	const realpath = path.resolve("node_modules", sourceModuleName);
	fs.mkdirSync(path.dirname(linkpath), { recursive: true });
	return { linkpath: linkpath, realpath: realpath };
}

async function workspaceLink(sourceModuleName: string, project: string) {
	const paths = await getLinkPaths(sourceModuleName, project);
	await $`ln -s ${packageMap[sourceModuleName]} ${paths.linkpath}`;
}

async function installedLink(sourceModuleName: string, project: string) {
	const paths = await getLinkPaths(sourceModuleName, project);
	await $`ln -s ${paths.realpath} ${paths.linkpath}`;
}

async function readPackageJsonFor(project: string) {
	const packageJsonPath = path.resolve(project, "package.json");
	const file = Bun.file(packageJsonPath);
	const contents = await file.json();
	return {
		...(contents.dependencies ?? {}),
		...(contents.devDependencies ?? {}),
		...(contents.peerDependencies ?? {}),
	};
}
