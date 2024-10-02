return {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
        -- Setup orgmode
        require("orgmode").setup({
            -- agenda ファイルを読み込むグローバルパス。複数の場合は、配列で定義する。
            org_agenda_files = "~/til/learn/orgmemo/**/*",

            -- リファイリング時にデフォルトのターゲットファイルとして使用されるファイルへのパス。
            org_default_notes_file = "~/orgfiles/refile.org",

            -- 未完了ステータスと完了ステータスのリストを定義する。
            -- `|` は未完了と完了を分割する。もし`|`がない場合は、全て終了ステータスとして解釈される。
            -- 少なくとも１つのエンティティにクイックアクセスキーを割り当てることができる。
            org_todo_keywords = { "TODO(t)", "WAITING(w)", "|", "CANCELED(c)", "DONE(d)" },

            -- TODOキーワードのカスタムカラー。
            -- 以下のオプションが使える。
            -- :foreground 0xFFFFFF or :foreground blue
            -- :background 0xFFFFFF or :foreground blue
            -- :weight     bold
            -- :underline  on
            -- :slant      italic
            org_todo_keyword_faces = {
                TODO = ":foreground = green :weight bold",
                WAITING = ":foreground = blue :weight bold",
                CVANCELED = ":foreground = yellow :weight bold",
                DONE = ":foreground = red :weight bold",
            },
        })
    end,
}
