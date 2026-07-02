Contains Theo's Noctalia plugins.

# How to use

1. Open your Noctalia settings, then navigate to the Plugins tab.
2. Click "Add Source"
3. In SourceID, type `TheosPlugins`
4. In Location, paste `https://github.com/MurderAxolotl/NoctaliaPlugins`
5. Enable "Update on startup" (optional)
6. Click "Add Source"

Now you can enable whatever plugins you like!

# Plugins

### Governor State

Provides a simple indicator of the current CPU governor. Can toggle between `performance` and `powersave`, if `cpufreq-utils` is installed.

Uses either pkexec or sudo to run elevated commands. Ensure pkexec is available!
