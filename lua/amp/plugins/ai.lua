return {
  {
    'Exafunction/windsurf.vim',
    event = 'BufEnter',

    -- Default binds:
    -- Accept suggestion      codeium#Accept()               <Tab>
    -- Next suggestion        codeium#CycleCompletions(1)    <M-]>
    -- Previous suggestion    codeium#CycleCompletions(-1)   <M-[>
    -- Accept word            codeium#AcceptNextWord()       <C-k>
    -- Accept line            codeium#AcceptNextLine()       <C-l>
    -- Clear suggestion       codeium#Clear()                <C-]>
    -- Trigger suggestions    codeium#Complete()             <M-Bslash>
  }
}
