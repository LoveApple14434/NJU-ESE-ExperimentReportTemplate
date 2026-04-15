-- 阈值（等效中文字符数）
local NORMAL_LIMIT = 12   -- ≤ 此值不旋转
local ROT45_LIMIT  = 24   -- > NORMAL_LIMIT 且 ≤ 此值旋转45°，> 此值旋转90°

-- 计算加权长度：中文=1，其他=0.5
function get_weighted_length(str)
    local len = 0
    for ch in str:gmatch("([%z\1-\127\194-\244][\128-\191]*)") do
        local byte1 = ch:byte(1)
        if byte1 and byte1 >= 0xE4 and byte1 <= 0xE9 then
            len = len + 1          -- 中文字符
        else
            len = len + 0.5        -- 英文、数字、标点等
        end
    end
    return len
end

-- 包装旋转
function wrap_rotate(inlines, angle)
    local rotated = pandoc.List()
    rotated:extend(pandoc.List{pandoc.RawInline('latex', '\\rotatebox{' .. angle .. '}{')})
    rotated:extend(inlines)
    rotated:extend(pandoc.List{pandoc.RawInline('latex', '}')})
    return pandoc.Blocks{pandoc.Plain(rotated)}
end

-- 处理表格
function Table(t)
    if not t.head or #t.head.rows == 0 then
        return t
    end

    -- 收集所有表头的原始 Inlines 和加权总长度
    local cells_info = {}
    local total_weighted_len = 0

    for row_idx, row in ipairs(t.head.rows) do
        for cell_idx, cell in ipairs(row.cells) do
            if #cell.contents > 0 then
                local first_block = cell.contents[1]
                if first_block and (first_block.t == 'Plain' or first_block.t == 'Para') then
                    local inlines = first_block.content
                    local text = pandoc.utils.stringify(inlines)
                    local cell_len = get_weighted_length(text)
                    total_weighted_len = total_weighted_len + cell_len
                    table.insert(cells_info, {
                        row = row_idx,
                        col = cell_idx,
                        inlines = inlines
                    })
                end
            end
        end
    end

    -- 根据总加权长度决定角度
    local angle = nil
    if total_weighted_len > ROT45_LIMIT then
        angle = "90"
    elseif total_weighted_len > NORMAL_LIMIT then
        angle = "45"
    else
        angle = nil
    end

    -- 应用旋转
    if angle then
        for _, info in ipairs(cells_info) do
            local rotated_blocks = wrap_rotate(info.inlines, angle)
            t.head.rows[info.row].cells[info.col].contents = rotated_blocks
        end
    end

    return t
end

return {{Table = Table}}