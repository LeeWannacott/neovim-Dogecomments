
-- api commands reference 
-- local get_cursor_line_number = api.nvim_win_get_cursor(0)[1]
-- local set_line = api.nvim_set_current_line("hello")
-- local get_line = api.nvim_get_current_line() 

api = vim.api -- shorten calling the api

-- file types table
file = {}
file["python"] = "#"
file["javascript"] = "//"
file["lua"] = "--"
file["text"] = "**"

filetype = vim.bo.filetype
print(filetype)

if file[filetype] ~= nil then
    comment_marker = file[filetype]
elseif filetype[filetype] == nil then
    default_comment_syntax = "//"
    comment_marker = default_comment_syntax
end
if type(string.len(comment_marker)) ~= nil then
    length_of_comment_marker = string.len(comment_marker)
end
--
function comment_line()
    get_line = api.nvim_get_current_line() 
    first_non_space_char = string.find(get_line, '%S')
    leading_space = string.rep(" ",first_non_space_char-1)
    comment_marker_exists = get_line.sub(get_line,first_non_space_char,first_non_space_char + length_of_comment_marker-1)

    space_after_comment = " "
    space_after_comment_len = string.len(space_after_comment)

    if comment_marker_exists ~= comment_marker then
        set_line = api.nvim_set_current_line(leading_space .. comment_marker .. space_after_comment .. get_line.sub(get_line,first_non_space_char))
    elseif comment_marker_exists == comment_marker  then
        set_line = api.nvim_set_current_line(leading_space .. get_line.sub(get_line, first_non_space_char + length_of_comment_marker + space_after_comment_len))
    end
    end

return {
    comment_line = comment_line
}

-- TODO:s
--  [~] Place comments with the indentation level.
--  [~] Get filetype of file e.g .py, .js, .lua , etc. 
--  [~] Assign comment type based of filetype.

--  [] Single line comment for normal mode
--  [] Be able to place multiple line comments or multiline comments in visual mode.