<?php
/**
 * This is the configuration for PsySH.
 *
 * Similar to laravel/tinker, PsySH is a runtime developer console, interactive debugger and REPL for PHP.
 * Run "make psysh" to get your console.
 *
 * @see https://psysh.org
 */

declare(strict_types=1);

return [
    /**
     * PsySH uses symfony/var-dumper's casters for presenting scalars,
     * resources, arrays and objects. You can enable additional casters, or
     * write your own!
     *
     * Default: []
     */
    // 'casters' => [],

    /**
     * By default, output contains colors if support for them is detected. To
     * override, use:
     *
     *      \Psy\Configuration::COLOR_MODE_FORCED to force colors
     *      \Psy\Configuration::COLOR_MODE_DISABLED to disable colors
     *      \Psy\Configuration::COLOR_MODE_AUTO to detect terminal support
     */
    // 'colorMode' => \Psy\Configuration::COLOR_MODE_AUTO,

    /**
     * While PsySH ships with a bunch of great commands, it's possible to add
     * your own for even more awesome. Any Psy command added here will be
     * available in your Psy shell sessions.
     *
     * Default: []
     */
    'commands' => [
        new \Psy\Command\ParseCommand(),
        new \Psy\Command\PsyVersionCommand(),
    ],

    /**
     * "Default includes" will be included once at the beginning of every PsySH
     * session. This is a good place to add autoloaders for your favorite
     * libraries.
     *
     * Default: []
     */
    'defaultIncludes' => [
        __DIR__ . '/src/bootstrap.php',
    ],

    /**
     * If set to true, the history will not keep duplicate entries. Newest
     * entries override oldest. This is the equivalent of the
     * `HISTCONTROL=erasedups` setting in bash.
     *
     * Default: false
     */
    // 'eraseDuplicates' => false,

    /**
     * While PsySH respects the current `error_reporting` level, and doesn't
     * throw exceptions for all errors, it does log all errors regardless of
     * level. Set `errorLoggingLevel` to `0` to prevent logging non-thrown
     * errors. Set it to any valid `error_reporting` value to log only errors
     * which match that level.
     *
     * Default: E_ALL
     */
    // 'errorLoggingLevel' => E_ALL,

    /**
     * Always show array indexes (even for numeric arrays).
     *
     * Default: false
     */
    // 'forceArrayIndexes' => false,

    /**
     * Override output formatting colors.
     *
     * Available colors:
     *      black, red, green, yellow, blue, magenta, cyan, white and default.
     * Available options:
     *      bold, underscore, blink, reverse and conceal.
     *
     * Note that the exact effect of these colors and options on output depends on your terminal emulator application and settings.
     *
     * If you're having a hard time seeing error messages in your terminal try:
     * 'formatterStyles' => [
     *      name => [foreground, background, [options]],
     *      'error' => ['black', 'red', ['bold']],
     * ]
     *
     * Default: []
     */
    // 'formatterStyles' => [],

    /**
     * Sets the maximum number of entries the history can contain. If set to
     * zero, the history size is unlimited.
     *
     * Default: 0
     */
    // 'historySize' => 0,

    /**
     * PsySH defaults to interactive mode in a terminal, and non-interactive
     * mode when input is coming from a pipe.  To override, use:
     *
     *   \Psy\Configuration::INTERACTIVE_MODE_FORCED for interactive mode
     *   \Psy\Configuration::INTERACTIVE_MODE_DISABLED for non-interactive mode
     *   \Psy\Configuration::INTERACTIVE_MODE_AUTO to choose by connection type
     */
    // 'interactiveMode' => \Psy\Configuration::INTERACTIVE_MODE_AUTO,

    /**
     * If this is not set, it falls back to `less`. It is recommended that you
     * set up `cli.pager` in your `php.ini` with your preferred output pager.
     *
     * Default: cli.pager ini setting
     */
    // 'pager' => 'less',

    /**
     * Specify a custom prompt.
     *
     * Default: ">>>"
     */
    // 'prompt' => '>>>',

    /**
     * PsySH automatically inserts semicolons at the end of input if a statement
     * is missing one. To disable this, set `requireSemicolons` to true.
     *
     * Default: false
     */
    // 'requireSemicolons' => false,

    /**
     * Set the shell's temporary directory location. Defaults to  `/psysh` inside
     * the system's temp dir unless explicitly overridden.
     *
     * Default: follows XDG runtimeDir specification.
     */
    // 'runtimeDir' => sys_get_temp_dir(),

    /**
     * Display an additional startup message. You can color and style the
     * message thanks to the Symfony Console tags. See
     * https://symfony.com/doc/current/console/coloring.html for more details.
     *
     * Default: ""
     */
    'startupMessage' => "<info>See https://psysh.org</info>\n"
                      . "<info>Try: help</info>\n"
                      . "<info>The \$dic variable is available and holds the dependency injection container</info>",

    /**
     * You can disable tab completion if you want to. Not sure why you'd
     * want to.
     *
     * Default: true
     */
    // 'tabCompletion' => true,

    /**
     * You can write your own tab completion matchers, too! Here are some that
     * enable tab completion for MongoDB database and collection names:
     *
     * Default: []
     */
    'tabCompletionMatchers' => [
        // new \Psy\TabCompletion\Matcher\ClassAttributesMatcher(),
        // new \Psy\TabCompletion\Matcher\ClassMethodDefaultParametersMatcher(),
        // new \Psy\TabCompletion\Matcher\ClassMethodsMatcher(),
        // new \Psy\TabCompletion\Matcher\ClassNamesMatcher(),
        // new \Psy\TabCompletion\Matcher\CommandsMatcher(),
        // new \Psy\TabCompletion\Matcher\ConstantsMatcher(),
        // new \Psy\TabCompletion\Matcher\FunctionDefaultParametersMatcher(),
        // new \Psy\TabCompletion\Matcher\FunctionsMatcher(),
        // new \Psy\TabCompletion\Matcher\KeywordsMatcher(),
        // new \Psy\TabCompletion\Matcher\MongoClientMatcher(),
        // new \Psy\TabCompletion\Matcher\MongoDatabaseMatcher(),
        // new \Psy\TabCompletion\Matcher\ObjectAttributesMatcher(),
        // new \Psy\TabCompletion\Matcher\ObjectMethodDefaultParametersMatcher(),
        // new \Psy\TabCompletion\Matcher\ObjectMethodsMatcher(),
        // new \Psy\TabCompletion\Matcher\VariablesMatcher(),
    ],

    /**
     * Frequency of update checks when starting an interactive shell session.
     * Valid options are "always", "daily", "weekly", and "monthly".
     *
     * To disable update checks entirely, set to "never".
     *
     * Default: weekly
     */
    // 'updateCheck' => 'weekly',

    /**
     * Enable bracketed paste support. If you use PHP built with readline
     * (not libedit) and a relatively modern terminal, enable this.
     *
     * Default: false
     */
    'useBracketedPaste' => true,

    /**
     * By default, PsySH will use a 'forking' execution loop if pcntl is
     * installed. This is by far the best way to use it, but you can override
     * the default by explicitly disabling this functionality here.
     *
     * Default: true
     */
    // 'usePcntl' => true,

    /**
     * PsySH uses readline if you have it installed, because interactive input
     * is pretty awful without it. But you can explicitly disable it if you hate
     * yourself or something.
     *
     * If readline is disabled (or unavailable) then terminal input is subject
     * to the line discipline provided for TTYs by the OS, which may impose a
     * maximum line size (4096 chars in GNU/Linux, for example) with larger
     * lines being truncated before reaching PsySH.
     *
     * Default: true
     */
    // 'useReadline' => true,

    /**
     * PsySH uses a couple of UTF-8 characters in its own output. These can be
     * disabled, mostly to work around code page issues. Because Windows.
     *
     * Note that this does not disable Unicode output in general, it just makes
     * it so PsySH won't output any itself.
     *
     * Default: true
     */
    // 'useUnicode' => true,

    /**
     * Change output verbosity. This is equivalent to the `--verbose`, `-vv`,
     * `-vvv` and `--quiet` command line flags. Choose from:
     *
     *   \Psy\Configuration::VERBOSITY_QUIET (this is *really* quiet)
     *   \Psy\Configuration::VERBOSITY_NORMAL
     *   \Psy\Configuration::VERBOSITY_VERBOSE
     *   \Psy\Configuration::VERBOSITY_VERY_VERBOSE
     *   \Psy\Configuration::VERBOSITY_DEBUG
     *
     * Default : \Psy\Configuration::VERBOSITY_NORMAL
     */
    // 'verbosity' => \Psy\Configuration::VERBOSITY_NORMAL,

    /**
     * If multiple versions of the same configuration or data file exist, PsySH
     * will use the file with highest precedence, and will silently ignore all
     * others. With this enabled, a warning will be emitted (but not an
     * exception thrown) if multiple configuration or data files are found.
     *
     * This will default to true in a future release, but is false for now.
     *
     * Default : false
     */
    'warnOnMultipleConfigs' => true,
];
