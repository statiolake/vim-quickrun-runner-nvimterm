" quickrun: runner/nvimterm: Runs by neovim terminal feature.
"           based on runner/terminal.
" Author : thinca <thinca+vim@gmail.com>
"          statiolake <statiolake@gmail.com>
" License: zlib License

let s:VT = g:quickrun#V.import('Vim.ViewTracer')

let s:is_win = g:quickrun#V.Prelude.is_windows()
let s:runner = {
\   'config': {
\     'opener': 'new',
\     'into': 0,
\   },
\ }


function! s:runner.validate() abort
  if !has('nvim')
    throw 'Needs Neovim.'
  endif
  if !s:is_win && !executable('sh')
    throw 'Needs "sh" on other than MS Windows.'
  endif
endfunction

function! s:runner.init(session) abort
  let a:session.config.outputter = 'null'
endfunction

function! s:runner.run(commands, input, session) abort
  let command = join(a:commands, ' && ')
  if a:input !=# ''
    let inputfile = a:session.tempname()
    call writefile(split(a:input, "\n", 1), inputfile, 'b')
    let command = printf('(%s) < %s', command, inputfile)
  endif
  let cmd_arg = s:is_win ? ['cmd.exe', '/c', printf('(%s)', command)]
  \                      : ['sh', '-c', command]
  let options = { 'on_exit': funcref('self._job_on_exit', self) }

  let self._key = a:session.continue()
  let prev_window = s:VT.trace_window()
  execute self.config.opener
  let self._jobid = termopen(cmd_arg, options)
  if !self.config.into
    call s:VT.jump(prev_window)
  endif
endfunction

function! s:runner.sweep() abort
  if has_key(self, '_jobid') && self._jobid > 0
    while jobwait([self._jobid], 0)[0] == -1
      call jobstop(self._jobid)
    endwhile
  endif
endfunction

function! s:runner._job_on_exit(job, exit_status, event) abort
  call quickrun#session(self._key, 'finish', a:exit_status)
endfunction

function! quickrun#runner#nvimterm#new() abort
  return deepcopy(s:runner)
endfunction

