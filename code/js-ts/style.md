# Coding Style

- 2 spaces
- Always keep a space before and after (except if it would cause a trailing space):
  - `{` and `}`
  - Attribution
  - Conditional operators
- Always use `;` except on conditions, loops, `function`

```ts
if (condition) { // OK! Right!
if (x > y) // OK! Right!
const a = b; // OK! Right!

// --

if(condition){ // WRONG!
if (x>y) // WRONG!
const a=b; // WRONG!
const a = b // WRONG!
```

## Editor Config

```
end_of_line = lf
insert_final_newline = true
indent_style = space
indent_size = 2
trim_trailing_whitespace = true
```

## Variables

- Short objects can be declared in a single line, in this case don't use trailing comma
- If the object has too many properties then use multiple lines, always with a trailing comma

```ts
const empty = {};
const size = { width: 10, height: 20 };
const size = {
  width: 10,
  height: 20,
};
```

- Strings should use `'`
- Exceptions are template strings and HTML in React (which should be `"`)

```ts
const text = 'Single quotes';
const textComposed = `Template quotes ${size.width}x${size.height}`;
```

```jsx
render() {
  return (<div className="double-quotes">Hello World</div>);
}
```

For arrays:

```ts
const arr = [1, 2, 3];
arr[0] = 2;

const empty = [];
```

## Conditional

### IF

- Brackets and new line are **always** required

```ts
if (condition) {
  // code
}

if (!condition) {
  return;
}

if (err) {
  throw new Error('Something went wrong');
}
```

- When there are too many conditions make it clear what the composed condition mean. If it is going to be used in multiple places extract to a function and use `if (canContinue())`
- When breaking the condition in multiple lines, always keep the operator at the beginning of the line

```ts
if (canDrag && canMove) {
  // code
}

const canContinue = canDrag
  && canMove
  && canEditSizes
  && this.state.visible;
if (canContinue) {
  // code
}
```

- `if` / `else if` / `else` should use a new line

```ts
if (condition) {
  // code
}
else if (condition2) {
  // code
}
else {
  // code
}
```

### Switch

```ts
switch (action.type) {
  case types.Init:
    init(state, action);
    break;

  case types.Clear: {
    clear(state, action);
    break;
  }

  default:
    return;
}
```

### Ternary

- For short conditions you can use the same line
- When the condition and/or results are too long break into multiple lines
- `?` and `:` should be in front of the line

```ts
const value = condition ? 1 : 2;
const value = condition
  ? getValueFromService(this.paramX, this.paramY)
  : undefined;
```

## Loops

- Always keep a space after the loop keyword

```ts
for (let i = 0; i < 10; ++i) {
}

while (condition) {
}

do {
} while (condition);
```

## Functions

- Function name and `()` should be together
- Add a space after closing `()`
- Add a space after comma in arguments
- Opening bracket in the same line
- Anonymous functions should have a space between `function` and `(`
- No semicolon after the function block

```ts
function foo() {
}

function foo(width, height, area) {
}

function (x, y) {
}
```

- Arrow functions should always use `()`, even for a single parameter
- Add a semicolon after the code block

```ts
const handleClick = (event) => {
};

const clear = (text1, search) => {
};
```

## Export

```ts
export default function fn() {
}

export const types = {
};

export function foo() {

}
```

```jsx
export default class MultiSelect extends React.Component {
}
```

## Import

- Use correct syntax for each exported code

```ts
import { types } from './types'; // export const types = { }
import fn from './fn'; // export default fn() { }
import * as fns from './fn'; // fns.default, fns.types, fns.foo
```

- Sort imports (I use the pattern defined by [sort-imports plugin for vs-code](https://marketplace.visualstudio.com/items?itemName=peterjuras.sort-imports))

```ts
import './index.scss'; // unsorted
import 'jquery'; // unsorted
import 'bootstrap'; // unsorted

import * as $ from 'jquery';
import * as React from 'react';
import * as actions from '../../actions/home';
import * as boardService from '../../services/board';
import * as models from '../../api/models';

import MultiSelect, { MultiSelectComponent } from '../Shared/MultiSelect';

import Board from './Board';
import OrganizationSelect from './OrganizationSelect';
import RefreshButton from './RefreshButton';
import { RootState } from '../../reducers/index';
import { RouteComponentProps } from 'react-router';
import SelectViewMode from './SelectViewMode';
import { connect } from 'react-redux';
import parseUri from 'uri-sharp';
```

## React

- When opening `{` to add HTML code, always use a new line for the code
- In a loop the parameter (HTML) passed in should end with a trailing comma
- Always insert space after opening and before closing jsx expression braces
- VSCode settings:

```json
"javascript.format.insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces": true
"typescript.format.insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces": true
```

```jsx
render() {
  return (
    <div>
      {
        this.props.list.map(item =>
          <div key={ item.id }>
            text
            {
              this.props.shouldShow &&
              <div>Only if shouldShow is true this will be visible</div>
            }
          </div>,
        )
      }
    </div>
  );
}
```

- Example with inline code
  - Ternary operator
  - Events

```jsx
onClick = (event) => {
  this.setState({
    clicked: true,
  });
}

render() {
  return (
    <select onClick={ this.onClick }>
      <option value="">{ this.props.loading ? 'Loading...' : 'Select organization...' }</option>
    </select>
  );
}
```
