import React from 'react';
import { withComponentFeatures } from 'universal-dashboard'
import {
    KBarProvider,
    KBarPortal,
    KBarPositioner,
    KBarAnimator,
    KBarSearch,
} from "kbar/lib/index";

const searchStyle = {
    padding: "12px 16px",
    fontSize: "16px",
    width: "100%",
    boxSizing: "border-box",
    outline: "none",
    border: "none",
    background: "var(--background)",
    color: "var(--foreground)",
};

const animatorStyle = {
    maxWidth: "600px",
    width: "100%",
    background: "var(--background)",
    color: "var(--foreground)",
    borderRadius: "8px",
    overflow: "hidden",
    boxShadow: "var(--shadow)",
};

function RenderResults() {
    const { results, rootActionId } = useMatches();

    return (
        <KBarResults
            items={results}
            onRender={({ item, active }) =>
                <ResultItem
                    action={item}
                    active={active}
                    currentRootActionId={rootActionId}
                />
            }
        />
    );
}

const ResultItem = React.forwardRef(
    (
        {
            action,
            active,
            currentRootActionId,
        },
        ref
    ) => {
        const ancestors = React.useMemo(() => {
            if (!currentRootActionId) return action.ancestors;
            const index = action.ancestors.findIndex(
                (ancestor) => ancestor.id === currentRootActionId
            );
            // +1 removes the currentRootAction; e.g.
            // if we are on the "Set theme" parent action,
            // the UI should not display "Set theme… > Dark"
            // but rather just "Dark"
            return action.ancestors.slice(index + 1);
        }, [action.ancestors, currentRootActionId]);

        return (
            <div
                ref={ref}
                style={{
                    padding: "12px 16px",
                    background: active ? "var(--a1)" : "transparent",
                    borderLeft: `2px solid ${active ? "var(--foreground)" : "transparent"
                        }`,
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "space-between",
                    cursor: "pointer",
                }}
            >
                <div
                    style={{
                        display: "flex",
                        gap: "8px",
                        alignItems: "center",
                        fontSize: 14,
                    }}
                >
                    {action.icon && action.icon}
                    <div style={{ display: "flex", flexDirection: "column" }}>
                        <div>
                            {ancestors.length > 0 &&
                                ancestors.map((ancestor) => (
                                    <React.Fragment key={ancestor.id}>
                                        <span
                                            style={{
                                                opacity: 0.5,
                                                marginRight: 8,
                                            }}
                                        >
                                            {ancestor.name}
                                        </span>
                                        <span
                                            style={{
                                                marginRight: 8,
                                            }}
                                        >
                                            &rsaquo;
                                        </span>
                                    </React.Fragment>
                                ))}
                            <span>{action.name}</span>
                        </div>
                        {action.subtitle && (
                            <span style={{ fontSize: 12 }}>{action.subtitle}</span>
                        )}
                    </div>
                </div>
                {action.shortcut?.length ? (
                    <div
                        aria-hidden
                        style={{ display: "grid", gridAutoFlow: "column", gap: "4px" }}
                    >
                        {action.shortcut.map((sc) => (
                            <div
                                key={sc}
                                style={{
                                    padding: "4px 6px",
                                    background: "rgba(0 0 0 / .1)",
                                    borderRadius: "4px",
                                    fontSize: 14,
                                }}
                            >
                                {sc}
                            </div>
                        ))}
                    </div>
                ) : null}
            </div>
        );
    }
);

function CommandBar() {
    return (
        <KBarPortal>
            <KBarPositioner>
                <KBarAnimator style={animatorStyle}>
                    <KBarSearch style={searchStyle} />
                    <RenderResults />
                </KBarAnimator>
            </KBarPositioner>
        </KBarPortal>
    );
}

const UDComponent = props => {

    const actions = props.action.map(action => {
        return {
            ...action,
            icon: action.icon ? props.render(action.icon) : null,
            perform: () => props.onPerform(action)
        }
    });

    return (
        <KBarProvider actions={actions}>
            <CommandBar />
            {props.render(props.children)}
        </KBarProvider>
    );
}

export default withComponentFeatures(UDComponent)