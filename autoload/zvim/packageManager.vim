let s:save_cpo = &cpo
set cpo&vim

function! s:install_manager()
  " Fsep && Psep
  if has('win16') || has('win32') || has('win64')
    let s:Psep = ';'
    let s:Fsep = '\'
  else
    let s:Psep = ':'
    let s:Fsep = '/'
  endif

  let s:directory = '~/.cache/dein'

  "auto install dein
  if filereadable(expand(s:directory)
		\ . join(['repos', 'github.com',
		\ 'Shougo', 'dein.vim', 'README.md'],
		\ s:Fsep))
    let g:spacevim_dein_installed = 1
  else
	  if executable('git')
      exec '!git clone https://github.com/Shougo/dein.vim '
            \ . s:directory
            \ . join(['repos', 'github.com',
            \ 'Shougo', 'dein.vim'], s:Fsep)
		  let g:spacevim_dein_installed = 1
	  else
		  echohl WarningMsg
		  echom "You need install git!"
		  echohl None
	  endif
  endif
  exec 'set runtimepath+='.s:directory
			  \ . join(['repos', 'github.com', 'Shougo',
			  \ 'dein.vim'], s:Fsep)
endf

call s:install_manager()

" function! zvim#plug#begin(path) abort
"     let g:unite_source_menu_menus.AddedPlugins =
"                 \ {'description':
"                 \ 'All the Added plugins'
"                 \ . '                    <leader>lp'}
"     let g:unite_source_menu_menus.AddedPlugins.command_candidates = []
"     nnoremap <silent><Leader>lp :Unite -silent
"                 \ -winheight=17 -start-insert menu:AddedPlugins<CR>
"     if g:spacevim_plugin_manager == 'neobundle'
"         call neobundle#begin(a:path)
"     elseif g:spacevim_plugin_manager == 'dein'
"         call dein#begin(a:path)
"     elseif g:spacevim_plugin_manager == 'vim-plug'
"         call plug#begin(a:path)
"     endif
" endfunction
"
" function! zvim#plug#end() abort
"     if g:spacevim_plugin_manager == 'neobundle'
"         call neobundle#end()
"         if g:spacevim_checkinstall == 1
"             NeoBundleCheck
"         endif
"     elseif g:spacevim_plugin_manager == 'dein'
"         call dein#end()
"         if g:spacevim_checkinstall == 1
"             silent! let flag = dein#check_install()
"             if flag
"                 augroup SpaceVimCheckInstall
"                     au!
"                     au VimEnter * call dein#install()
"                 augroup END
"             endif
"         endif
"         call dein#call_hook('source')
"     elseif g:spacevim_plugin_manager == 'vim-plug'
"         call plug#end()
"     endif
" endfunction
"
" function! zvim#plug#defind_hooks(bundle) abort
"     if g:spacevim_plugin_manager == 'neobundle'
"         let s:hooks = neobundle#get_hooks(a:bundle)
"         func! s:hooks.on_source(bundle) abort
"             call zvim#util#source_rc('plugins/' . split(a:bundle['name'],'\.')[0] . '.vim')
"         endf
"     elseif g:spacevim_plugin_manager == 'dein'
"         call dein#config(g:dein#name, {
"                     \ 'hook_source' : "call zvim#util#source_rc('plugins/" . split(g:dein#name,'\.')[0] . ".vim')"
"                     \ })
"     endif
" endfunction
"
" function! zvim#plug#fetch() abort
"     if g:spacevim_plugin_manager == 'neobundle'
"         NeoBundleFetch 'Shougo/neobundle.vim'
"     elseif g:spacevim_plugin_manager == 'dein'
"         call dein#add('Shougo/dein.vim')
"     endif
" endfunction
"
" let s:plugins = []
"
" fu! s:parser(args)
"     return a:args
" endf
"
" function! zvim#plug#add(repo,...) abort
"     let g:spacevim_plugin_name = ''
"     if g:spacevim_plugin_manager == 'neobundle'
"         exec 'NeoBundle "'.a:repo.'"'.','.join(a:000,',')
"         let g:spacevim_plugin_name = split(a:repo, '/')[-1]
"     elseif g:spacevim_plugin_manager == 'dein'
"         if len(a:000) > 0
"             call dein#add(a:repo,s:parser(a:000[0]))
"         else
"             call dein#add(a:repo)
"         endif
"         let g:spacevim_plugin_name = g:dein#name
"     elseif g:spacevim_plugin_manager == 'vim-plug'
"         if len(a:000) > 0
"             exec "Plug '".a:repo."', ".join(a:000,',')
"         else
"             exec "Plug '".a:repo."'"
"         endif
"         let g:spacevim_plugin_name = split(a:repo, '/')[-1]
"     endif
"     let str = get(g:,'spacevim_plugin_layer', 'custom plugin')
"     let str = '[' . str . ']'
"     let str = str . repeat(' ', 25 - len(str))
"     exec 'call add(g:unite_source_menu_menus'
"                 \ . '.AddedPlugins.command_candidates, ["'. str . '['
"                 \ . a:repo
"                 \ . (len(a:000) > 0 ? (']'
"                 \ . repeat(' ', 40 - len(a:repo))
"                 \ . '[lazy loaded]  [' . string(a:000[0])) : '')
"                 \ . ']","OpenBrowser https://github.com/'
"                 \ . a:repo
"                 \ . '"])'
"     call add(s:plugins, a:repo)
" endfunction
"
" function! zvim#plug#tap(plugin) abort
"     if g:spacevim_plugin_manager == 'neobundle'
"         return neobundle#tap(a:plugin)
"     elseif g:spacevim_plugin_manager == 'dein'
"         return dein#tap(a:plugin)
"     endif
" endfunction
"
" function! zvim#plug#enable_plug() abort
"     return g:spacevim_neobundle_installed
"                 \ || g:spacevim_dein_installed
"                 \ || g:spacevim_vim_plug_installed
" endfunction
"
" function! zvim#plug#loadPluginBefore(plugin) abort
"     if matchend(a:plugin, ".vim") == len(a:plugin)
"         call zvim#util#source_rc('plugins_before/' . a:plugin)
"     else
"         call zvim#util#source_rc('plugins_before/' . a:plugin . '.vim')
"     endif
" endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
