Js.log("Hello, World!")

type player = Black | White

type tile = {
    id: int,
    player,
    pos: (int, int),
}

module PosCmp = Belt.Id.MakeComparable({
    type t = (int, int)
    let cmp = (a, b) => Pervasives.compare(a, b)
})
module Board = {
    open Belt
    type board = Map.t<(int, int), tile, PosCmp.identity>

    let isMovable = (board: board, x, y) => {
        let (
            left,
            right,
            up,
            down,
        ) =
            (
                (x-1, y),
                (x+1, y),
                (x, y+1),
                (x, y-1),
            )
            ->Array.map(
                pos =>
                    board->Map.get(pos)
                    ->Option.isSome
            )

        !((left && right) || (up && down))
    }
}

let m = Belt.Map.make(~id=module(PosCmp))

let p = m -> Belt.Map.set((1, 2), 1)

