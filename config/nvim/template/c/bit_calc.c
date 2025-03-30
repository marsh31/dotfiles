// あるレジスタのbit番目をセットする
#define SET_BIT(REG, BIT)  ((REG) |= (1U << (BIT)))

// 指定bitをクリアする
#define CLEAR_BIT(REG, BIT) ((REG) &= ~(1U << (BIT)))

// XOR でトグル
#define TOGGLE_BIT(REG, BIT) ((REG) ^= (1U << (BIT)))
{{_cursor_}}
