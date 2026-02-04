#!/usr/bin/env node

/**
 * Update version across all plugin files
 * Usage: node scripts/update-version.js <version>
 */

const fs = require('fs');
const path = require('path');

const version = process.argv[2];

if (!version) {
  console.log('Usage: node scripts/update-version.js <version>');
  console.log('Updates version in plugin.json, package.json, status.md, and CLAUDE.md');
  process.exit(0);
}

console.log(`Updating version to ${version}...`);

const root = path.join(__dirname, '..');

// Update package.json
const packageJsonPath = path.join(root, 'package.json');
const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'));
packageJson.version = version;
fs.writeFileSync(packageJsonPath, JSON.stringify(packageJson, null, 2) + '\n');
console.log('  ✓ package.json');

// Update .claude-plugin/plugin.json
const pluginJsonPath = path.join(root, '.claude-plugin', 'plugin.json');
const pluginJson = JSON.parse(fs.readFileSync(pluginJsonPath, 'utf8'));
pluginJson.version = version;
fs.writeFileSync(pluginJsonPath, JSON.stringify(pluginJson, null, 2) + '\n');
console.log('  ✓ .claude-plugin/plugin.json');

// Update commands/status.md
const statusMdPath = path.join(root, 'commands', 'status.md');
let statusMd = fs.readFileSync(statusMdPath, 'utf8');
statusMd = statusMd.replace(/version: [\d.]+/g, `version: ${version}`);
statusMd = statusMd.replace(/\*\*Plugin Version: [\d.]+\*\*/g, `**Plugin Version: ${version}**`);
statusMd = statusMd.replace(/Plugin Version: [\d.]+/g, `Plugin Version: ${version}`);
fs.writeFileSync(statusMdPath, statusMd);
console.log('  ✓ commands/status.md');

// Update CLAUDE.md
const claudeMdPath = path.join(root, 'CLAUDE.md');
let claudeMd = fs.readFileSync(claudeMdPath, 'utf8');
claudeMd = claudeMd.replace(/# Hotwired Plugin v[\d.]+/g, `# Hotwired Plugin v${version}`);
claudeMd = claudeMd.replace(/\*\*Plugin Version\*\*: [\d.]+/g, `**Plugin Version**: ${version}`);
fs.writeFileSync(claudeMdPath, claudeMd);
console.log('  ✓ CLAUDE.md');

console.log(`\n✨ Version updated to ${version}`);
